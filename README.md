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

- `bash`, `curl`, `cmake`, `nproc` and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- [ROOT's dependencies](https://root.cern/install/dependencies/)

# Simple install

Plugin:

```shell
asdf plugin add root https://github.com/gabrielmscampos/asdf-root.git
```

root:

```shell
# Show all installable versions
asdf list-all root

# Install specific version
asdf install root latest

# Set a version globally (on your ~/.tool-versions file)
asdf set --home root latest

# Now root commands are available
root --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

Check [root](https://root.cern/install/) website for more instructions on how to install ROOT.

# Install ROOT for multiple python versions

When compiling ROOT from scratch (as this plugin does), it automatically detects the current Python installation. However, you cannot install the same ROOT version multiple times using asdf. If you need the same ROOT version with different Python versions, you'll have to duplicate the installation under a different "plugin" name and then reinstall ROOT for the desired Python version.

**Example: Installing ROOT v6-32-10 for Python 3.10.X and 3.9.X**

```shell
# Install Python
asdf plugin add python
asdf install python 3.10.13
asdf install python 3.9.19

# Let's first setup ROOT for python 3.10.X
asdf set python 3.10.13
asdf plugin add root-python310 https://github.com/gabrielmscampos/asdf-root.git
asdf install root-python310 6-32-10
asdf set root-python310 6-32-10

# Now setup ROOT for python 3.9.X
asdf set python 3.9.19
asdf plugin add root-python39 https://github.com/gabrielmscampos/asdf-root.git
asdf install root-python39 6-32-10
asdf set root-python39 6-32-10
```

This approach ensures that you can use ROOT v6-32-10 with both Python 3.10 and 3.9 by managing separate plugin names for each Python version.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/gabrielmscampos/asdf-root/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Gabriel Moreira](https://github.com/gabrielmscampos/)
