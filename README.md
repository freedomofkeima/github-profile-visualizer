# Github Profile Visualizer

Visualize Github profile growth (followers, num repo, etc) with daily cron and Github Pages.

Available via Github Pages - [https://freedomofkeima.github.io/github-profile-visualizer/](https://freedomofkeima.github.io/github-profile-visualizer/).

![](img/screenshot.png)

## Make Your Own Github Pages

Github provides a free, static page websites via [Github Pages](https://pages.github.com/). In order to start using it, you need to:

* Fork this repo.
* Open your repo setting and scroll down to Github Pages. Change your `source` and save. Your setup should look like below.

![Enable github pages for this project](img/pages.png)

* Clone your repo to your computer and run `sh init.sh GITHUB_USERNAME GITHUB_TOKEN`. Read the guide below on how to generate your token.
* Run `sh script.sh` (or `./script.sh`) to update and upload your data. Add cron job integration (explained below) to automatically update your repository everyday.
* Check if it works, visit `https://[GITHUB_USERNAME].github.io/github-profile-visualizer/`.


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

![Scope](img/scope.png)

`public_repo` is used to allow us committing daily cron changes back to the repository, while `repo:status` is used to get number of repositories, and `read:user` is used to get number of followers & followings.

## ok.sh

`ok.sh` is adapted from [whiteinge/ok.sh](https://github.com/whiteinge/ok.sh), which has BSD 3-Clause.

As of October 3, 2018, `ok.sh` doesn't support `list_followers` and `list_following`. Therefore, `ok.sh` in this repository is a freezed version with modifications.

We will store "Personal Access Token" that you have retrieved above in `$HOME/.netrc`. See `init.sh` for details implementation.

For other optional configurations, consult to [whiteinge/ok.sh#configuration](https://github.com/whiteinge/ok.sh#configuration).

## script.sh

Assuming your repository clone is located at `$HOME`, you can try running `script.sh` manually via:

```
$ GITHUB_USER=[YOUR_USERNAME] GITHUB_TOKEN=[YOUR_TOKEN] $HOME/github-profile-visualizer/script.sh
```

## Adding cron job

At this point, you should be able to see a new commit in your repository, congrats!

The next step is, we want to automate the job. You can add the following line to your crontab (`crontab -e`):

```
0 10 * * * GITHUB_USER=[YOUR_USERNAME] GITHUB_TOKEN=[YOUR_GENERATED_TOKEN] $HOME/github-profile-visualizer/script.sh &>/dev/null
```

Feel free to adjust the parameter above (schedule, source path, etc) based on your configuration.

## Contributors

- [Iskandar Setiadi](https://github.com/freedomofkeima)
- [Tegar Imansyah](https://github.com/tegarimansyah)

## License

This project is licensed under BSD 3-Clause.
