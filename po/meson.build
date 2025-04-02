
i18n.gettext(meson.project_name(),
    preset: 'glib',
    data_dirs: meson.source_root() / 'data',
)

pot_target = custom_target('always-build-pot',
  command: [
    find_program('ninja'),
    '-C', meson.build_root(),
    'shared-mime-info-pot'
  ],
  output: 'pot-timestamp',
  build_by_default: true
)

test('translations', find_program('check_translations.sh'))
