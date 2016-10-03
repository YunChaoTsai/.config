# up: https://github.com/justinmayer/tackle/tree/master/plugins/up
function up -d "Update software to the latest versions"
    if contains "all" $argv
        git -C $HOME/.tacklebox pull > /dev/null
        git -C $HOME/.tackle pull > /dev/null
        which brew >/dev/null
        and begin
            brew update
            brew upgrade
        end
        set -l plugins python
        for plugin in $plugins
            if contains $plugin $tacklebox_plugins
                up $plugin
            end
        end
        fish_update_completions
    else
        for arg in $argv
            if contains $arg $tacklebox_plugins
                switch $arg
                    case "python"
                        if test -z $VIRTUAL_ENV
                            set -l os (uname)
                            if test "$os" = "Linux"
                                set -l sudo "sudo"
                            else
                                set -l sudo ""
                            end
                            set -l outdated (env PIP_REQUIRE_VIRTUALENV="" pip list --outdated | cut -d ' ' -f 1)
                            for pkg in $outdated
                                set python_packages_to_upgrade $python_packages_to_upgrade $pkg
                            end
                            if test -z "$python_packages_to_upgrade"
                                echo "Python packages to up-to-date."
                            else
                                env PIP_REQUIRE_VIRTUALENV="" $sudo pip install --upgrade $python_packages_to_upgrade
                                set -e python_packages_to_upgrade
                            end
                        else
                            if test -f requirements.txt
                                pip install --upgrade -r requirements.txt
                            else
                                set -l outdated (pip list --outdated | cut -d ' ' -f 1)
                                pip install --upgrade $outdated
                            end
                        end
                end
            else
                echo "Could not locate that plugin in your tacklebox_plugins setting."
            end
        end
    end
end
