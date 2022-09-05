#!/bin/bash

git_array=('/.git' '/_wpeprivate/config.json' '/.git-rewrite' '/.git/HEAD' '/.git/index' '/.git/logs' '/.gitattributes' '/.gitconfig' '/.gitkeep' '/.gitmodules' '/.gitreview' '/.svn/entries' '/.svnignore' '/.svn/wc.db' '/.git/config')
wp_array=('/wp-includes' '/index.php' '/wp-login.php' '/wp-links-opml.php' '/wp-activate.php' '/wp-blog-header.php' '/wp-cron.php' '/wp-links.php' '/wp-mail.php' '/xmlrpc.php' '/wp-settings.php' '/wp-trackback.php' '/wp-admin/setup-config.php?step=1' '/wp-content/plugins/supportboard/supportboard/include/ajax.php' '/wp_inc/' '/wp-config.php.bkp' '/wp-config.php' '/wp-admin/install.php' '/wp-content/plugins/wp-statistics/readme.txt' '/themes/search' '/wp-json/') 
arqSen=('/ghost/api/canary/admin/setting' '/graphql' '/api/login/' '/.travis.yml' '/.htaccess' '/.bash_history' '/.ssh/known_hosts')
arqSen1=('/.travis.yml' '/.htaccess' '/.bash_history' '/.ssh/known_hosts')

banner2()
{
echo "Use: bash W0rdpr3ss-ch3ck-v.0.1.sh https://dominio.com opcao"
echo 
echo "n = check se dominio possui wordpress"
echo "w = check dominio & arquivos sensiveis wordpress"
echo "g = check .git exposed"
echo "wg = check arquivos sensiveis wordpress & .git exposed"
echo "a = check arquivos sensiveis"
echo "ag = check arquivos sensiveis & .git exposed"

}

banner()
{
echo
echo -e '\e[1;32m""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
echo '"      888       888   .d8888b.               888   8888888b.         .d8888b.                     "' 
echo '"      888   o   888  d88P  Y88b              888   888   Y88b       d88P  Y88b                    "' 
echo '"      888  d8b  888  888    888              888   888    888            .d88P                    "' 
echo '"      888 d888b 888  888    888 888d888  .d88888   888   d88P 888d888   8888"  .d8888b  .d8888b   "' 
echo '"      888d88888b888  888    888 888P"   d88" 888   8888888P"  888P"      "Y8b. 88K      88K       "' 
echo '"      88888P Y88888  888    888 888     888  888   888        888   888    888 "Y8888b. "Y8888b.  "' 
echo '"      8888P   Y8888  Y88b  d88P 888     Y88b 888   888        888   Y88b  d88P      X88      X88  "' 
echo '"      888P     Y888   "Y8888P"  888      "Y88888   888        888    "Y8888P"   88888P"  88888P"  "' 
echo '"                                                                                                  "'
echo '"                                                                                                  "'
echo '"     .d8888b.  888       .d8888b.           888          888     888    .d8888b.       d888       "'
echo '"    d88P  Y88b 888      d88P  Y88b          888          888     888   d88P  Y88b     d8888       "'
echo '"    888    888 888           .d88P          888          888     888   888    888       888       "'
echo '"    888        88888b.      8888"   .d8888b 888  888     Y88b   d88P   888    888       888       "'
echo '"    888        888 "88b      "Y8b. d88P"    888 .88P      Y88b d88P    888    888       888       "'
echo '"    888    888 888  888 888    888 888      888888K 888888 Y88o88P     888    888       888       "'
echo '"d8b Y88b  d88P 888  888 Y88b  d88P Y88b.    888 "88b        Y888P  d8b Y88b  d88P d8b   888   d8b "'
echo '"Y8P  "Y8888P"  888  888  "Y8888P"   "Y8888P 888  888         Y8P   Y8P  "Y8888P"  Y8P 8888888 Y8P "'
echo -e '""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""\e[0m'
echo '  _                             _             __             '
echo ' /  ._ _   _| o _|_  _   _ o   |_) | |_|_ _| (_   _ |_|_ ._  '
echo ' \_ | (/_ (_| |  |_ (_) _> o   |_) |   | (_| __) (_   |  | | '
echo
echo -e "\e[1;37mLivre uso e modificacao, mantenha os creditos em comentario.\e[0m"
echo -e "\e[1;31mPs: Nao faca teste em dominios sem permissao\e[0m"
echo

}

if [ -z "$1" ];
then
    banner
    banner2
    exit;
elif [ -z "$2" ];
then
    banner
    banner2
    exit;
fi

banner
rm index 2>/dev/null 1>/dev/null
curl -s -q $1 > index
a=`cat index | egrep -Eo "wp-"`

if [[ $2 == "a" ]];
then
    echo -e "\e[1;32mProcurando Arquivos Sensiveis\e[0m"
   for o in $(printf '%s\n' ${arqSen[@]} ${arqSen1[@]});do echo $1$o | httpx -title -sc -silent;done

elif [[ $2 == "g" ]];
then
   echo -e "\e[1;32mProcurando Arquivos sensiveis & Git Exposed\e[0m"
   for o in $(printf '%s\n' ${git_array[@]} ${arqSen1[@]});do echo $1$o | httpx -title -sc -silent;done 

elif [[ $2 == "wg" ]];
then
    echo -e "\e[1;32mProcurando Arquivos Sensiveis & Wordpress & Git Exposed \e[0m"
	if [[ $a == "" ]];
    then 
       
        echo "Nao Foi identificado Wordpress no dominio $1"
        echo -e "\e[1;32mProcurando Arquivos sensiveis & .git exposed\e[0m"
		for o in $(printf '%s\n' ${git_array[@]} ${arqSen1[@]});do echo $1$o | httpx -silent -title -sc;done
    else
        echo "Foi identificado Wordpress no dominio $1 continuando o recon..."
        for o in $(printf '%s\n' ${git_array[@]} ${wp_array[@]} ${arqSen1[@]});do echo $1$o | httpx -silent -title -sc;done
    fi
    
elif [[ $2 == "ag" ]];
then
    echo -e "\e[1;32mProcurando Arquivos Sensiveis & Git Exposed\e[0m"
    for o in $(printf '%s\n' ${git_array[@]} ${arqSen[@]} ${arqSen1[@]});do echo $1$o | httpx -silent -title -sc;done

elif [[ $2 == "w" ]];
then
    echo -e "\e[1;32mProcurando Arquivos Sensiveis & WordPress\e[0m"
    if [[ $a == "" ]];
    then 
        echo "Nao Foi identificado Wordpress no dominio $1"
        exit;
    else
	    echo -e "\e[1;32mFoi identificado Wordpress no dominio $1 continuando com recon..\e[0m"
        for o in $(printf '%s\n' ${wp_array[@]} ${arqSen1[@]});do echo $1$o | httpx -silent -title -sc;done

    fi

elif [[ $2 == "n" ]];
then
    if [[ $a == "" ]];
    then 
        echo -e "\e[1;32mIdentificando Wordpress\e[0m"
        echo "Nao Foi identificado Wordpress no dominio $1"

    else
        echo -e "\e[1;32mIdentificando Wordpress\e[0m"
        echo "Foi identificado Wordpress no dominio $1"

    fi
fi
