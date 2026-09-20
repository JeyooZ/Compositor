#!/usr/bin/env python3
"""Validate resource syntax, duplicate keys, placeholders and explicit lookup coverage."""
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def read(language, table):
    path = ROOT / 'Compositor' / f'{language}.lproj' / f'{table}.strings'
    subprocess.run(['plutil', '-lint', str(path)], check=True)
    data = json.loads(subprocess.check_output(['plutil', '-convert', 'json', '-o', '-', str(path)]))
    keys = re.findall(r'^"((?:[^"\\]|\\.)*)"\s*=', path.read_text(), re.M)
    assert len(keys) == len(set(keys)), f'Duplicate keys: {path}'
    return data

for table in ['Localizable', 'InfoPlist']:
    en, zh = read('en', table), read('zh-Hans', table)
    assert en.keys() == zh.keys(), f'{table}: language keys differ'
    for key in en:
        assert zh[key].strip(), f'Empty translation: {key}'
        pattern = r'%(?:\d+\$)?[@diufsg]'
        assert sorted(re.findall(pattern, en[key])) == sorted(re.findall(pattern, zh[key])), f'Format mismatch: {key}'
    print(f'{table}: {len(en)} matching English/Chinese entries')
    if table == 'Localizable':
        for source in (ROOT / 'Compositor').rglob('*.swift'):
            for match in re.finditer(r'L10n\.(?:string|format)\("((?:[^"\\]|\\.)*)"\s*[,)]', source.read_text()):
                key = json.loads('"' + match[1] + '"')
                assert key in en, f'{source.relative_to(ROOT)}: missing {key}'
print('Localization resources passed.')
