# Contributing

## Tools

1. Install `asdf` tools

    ```shell
    asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git
    asdf plugin add shfmt https://github.com/luizm/asdf-shfmt.git
    asdf install
    ```

1. Develop!

1. Lint & Format

    ```shell
    ./scripts/format.bash
    ./scripts/lint.bash
    ```

1. PR changes

## Testing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test root https://github.com/gabrielmscampos/asdf-root.git "root --version"
```

Tests are automatically run in GitHub Actions on push and PR.
