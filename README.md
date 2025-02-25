<div align="center">

# asdf-root [![Build](https://github.com/gabrielmscampos/asdf-root/actions/workflows/build.yml/badge.svg)](https://github.com/gabrielmscampos/asdf-root/actions/workflows/build.yml) [![Lint](https://github.com/gabrielmscampos/asdf-root/actions/workflows/lint.yml/badge.svg)](https://github.com/gabrielmscampos/asdf-root/actions/workflows/lint.yml)

[root](https://root.cern/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add root
# or
asdf plugin add root https://github.com/gabrielmscampos/asdf-root.git
```

root:

```shell
# Show all installable versions
asdf list-all root

# Install specific version
asdf install root latest

# Set a version globally (on your ~/.tool-versions file)
asdf global root latest

# Now root commands are available
root --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/gabrielmscampos/asdf-root/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Gabriel Moreira](https://github.com/gabrielmscampos/)
