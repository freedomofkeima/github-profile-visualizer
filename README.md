# Github Profile Visualizer

Work in Progress.

## Github Personal Access Token

To access Github, we need to create a personal access token.

Access [https://github.com/settings/tokens/new](https://github.com/settings/tokens/new) to generate a new personal token.


We need to set the following 3 scopes:

```
"scopes": [
	"public_repo",
	"repo:status",
	"read:user"
]
```

`public_repo` is used to allow us commiting daily cron changes back to the repository, while `repo:status` is used to get number of repositories, and `read:user` is used to get number of followers & followings.

## ok.sh

`ok.sh` is adapted from [whiteinge/ok.sh](https://github.com/whiteinge/ok.sh), which has BSD 3-Clause.

As of October 3, 2018, `ok.sh` doesn't support `list_followers` and `list_following`. Therefore, `ok.sh` in this repository is a freezed version with modifications.

You need to use "Personal Access Token" that you have retrieved above in `$HOME/.netrc`. Ensure that the permission is restricted with `chmod 600 ~/.netrc`!

```
machine api.github.com
    login <username>
    password <token>

machine uploads.github.com
    login <username>
    password <token>
```

For other optional configurations, consult to [whiteinge/ok.sh#configuration](https://github.com/whiteinge/ok.sh#configuration).

## script.sh

Assuming your repository clone is located at `$HOME`, then you can try running `script.sh` via:

```
$ GITHUB_USER=[YOUR_USERNAME] $HOME/github-profile-visualizer/script.sh
```

## License

This project is licensed under BSD 3-Clause.
