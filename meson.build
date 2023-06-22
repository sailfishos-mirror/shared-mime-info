
project('shared-mime-info',
    'c',
    version: '2.2',
    meson_version: '>=0.49.0'
)

config = configuration_data()

i18n = import('i18n')

cc = meson.get_compiler('c')

###############################################################################
# Project configuration

config.set_quoted('PACKAGE', meson.project_name())
config.set_quoted('VERSION', meson.project_version())

###############################################################################
# Find tools

xmllint = find_program('xmllint')
xmlto   = find_program('xmlto', required: false)

###############################################################################
# Find xdgmime

xdgmime = get_option('xdgmime-path')

xdgmime_print_mime_data = find_program(xdgmime/'print-mime-data', 'print-mime-data', required: false)
xdgmime_test_mime_data  = find_program(xdgmime/'test-mime-data', 'test-mime-data', required: false)
xdgmime_test_mime       = find_program(xdgmime/'test-mime', 'test-mime', required: false)
xdgmime_found = (
    xdgmime_print_mime_data.found() and
    xdgmime_test_mime_data.found()  and
    xdgmime_test_mime.found()
)

if not xdgmime_found
    warning('''
***************************************************************************
*** xdgmime not compiled, test suite cannot run. Check HACKING for info ***
***************************************************************************
    ''')
endif

###############################################################################
# Dependencies

check_functions = [
    'fdatasync',
]
foreach function : check_functions
    config.set('HAVE_'+function.to_upper(), cc.has_function(function))
endforeach


if get_option('build-translations')
    subdir('po')
endif
subdir('data')
if get_option('build-tools')
    libxml = dependency('libxml-2.0',   version: '>=2.4')
    glib2  = dependency('glib-2.0',     version: '>=2.6.0')

    gio = dependency('gio-2.0', required: false)
    subdir('src')
endif
if get_option('build-tests')
    subdir('tests')
endif

configure_file(
    input: 'shared-mime-info.pc.in',
    output: '@BASENAME@',
    configuration: {
        'prefix': get_option('prefix'),
        'VERSION': meson.project_version()
    },
    install_dir: get_option('datadir') / 'pkgconfig'
)

if get_option('update-mimedb')
    upd_tool = (meson.is_cross_build() or not get_option('build-tools')
        ? find_program('update-mime-database').path()
        : update_mime_database.full_path()
    )
    meson.add_install_script('sh', '-c', ' '.join([
        upd_tool, '-V', '${MESON_INSTALL_DESTDIR_PREFIX}' / get_option('datadir') / 'mime',
    ]))
endif
