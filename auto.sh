#1/bin/bash

hexo clean
hexo g

if [ "$1" == "-d" ]; then
    echo "**************** Deploying myBlog to GitHub ********************"
    cp README.md .deploy_git/
    cp README.md public/
    if [ "$2" == "-m" ]; then
        hexo d -m "$3"
        #echo "hexo d -m " $3
    else
        #echo "hexo d -m 'Default Update'"
        hexo d -m "Default Update"
    fi
else
    echo "************* Local Testing myBlog *****************"
    # preview draft at local
    #hexo s --drafts
    # preview witout drafts
    hexo s
fi
