Note: latest version of this file is at:
https://gitlab.freedesktop.org/xdg/shared-mime-info/-/blob/master/HACKING.md

A few ground rules for people interested in adding new mime-types.

* Mime-types used should be IANA registered mime-types when possible
* When old mime-types become registered, the new definition should
  include an alias for the old mime-type
* New entries or modifications should include a test case (see below)
* Mime-types/file formats proprietary to one application should only
  be added to a private .xml file and be bundled with the application
  itself
* Magic offset must be as small as possible. For example, the worst case
  scenario for ISO images is 32k inside the file. This is too big for a sniff
  buffer, especially on remote locations. Avoid those.
* No commits should be done that break the test suite, or the test suite
  test in question should be amended, and reason for the changes clearly
  documented in the commit message

Translations
------------

Translations should go through Transifex.com, and the freedesktop.org team:
http://www.transifex.com/projects/p/shared-mime-info/

Filing bugs
-----------

Bugs can be filed at:
https://gitlab.freedesktop.org/xdg/shared-mime-info/issues

Merge requests are required for new mime-types and should include one or
more test files to be added to the test suite.

Test suite
----------

You need to have xdgmime [1] checked out and compiled. In the shared-mime-info
git repository, getting xdgmime is taken care of by using a git submodule; run
`git submodule update --init` after cloning the shared-mime-info repo. If
you wish to keep the submodule automatically up to date on pull, `git config
submodule.recurse true` in the shared-mime-info dir helps with that.

By default, the build system will expect the xdgmime directory to be in the
shared-mime-info directory. `./xdgmime/src/test-mime-data` is run against
`tests/mime-detection/list`. An alternate path to xdgmime can be passed by
using the `xdgmime-path` meson option such as `-Dxdgmime-path=/path/to/xdgmime`.

The format of the file is:
`<testcase filename> <expected mime-type> <expected failures>`

The expected failures is whether matching the file with the mime-type would
fail when matched by file, data or name. "x" indicates expected failure, "o"
indicates expected success. Trailing "o"s can be omitted.

See the top of the `tests/mime-detection/list` file for syntax details.

You can also temporarily print the results of `test-mime-data` by putting your
test files in the `staging-tests/` sub-directory.

[1]: Repository details at:
https://gitlab.freedesktop.org/xdg/xdgmime

Releasing
---------

- Run `ninja shared-mime-info-pot`, `./po/check_translations.sh` and
  `./po/update_translations.sh` before release
- Commit and push to shared-mime-info gitlab
- Update version number in `meson.build`
- Add changelog to `NEWS`
     git log --pretty=format:'* %s' <prevtag>..
- Commit, make a merge request, wait for CI to ensure `meson dist` works, then merge it.
- Tag and push the tag
- Go to https://gitlab.freedesktop.org/xdg/shared-mime-info/-/releases and click "New release"
  - Fill in version number (3 times), paste NEWS, confirm

Updating the spec on the website
--------------------------------

- update https://gitlab.freedesktop.org/xdg/xdg-specs/blob/master/web-export/specs.idx
