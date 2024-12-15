trap 'printf "\n";partial;exit 1' 2

BrightRed="\e[1;91m"
BrightGreen="\e[1;92m"
BrightYellow="\e[1;93m"
BrightWhite="\e[1;97m"
# Function to install dependencies
install_dependencies() {
    echo -e "${BrightWhite}[${BrightYellow}*${BrightWhite}] ${BrightYellow}Checking and installing dependencies...\033[0m"

    # For Termux
    if [ -d "/data/data/com.termux/files/usr" ]; then
        echo -e "${BrightWhite}[${BrightGreen}*${BrightWhite}] ${BrightGreen}Detected Termux environment\033[0m"
        
        # Install curl if missing
        if ! command -v curl &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}curl not found, installing...\033[0m"
            pkg install curl -y
        fi

        # Install grep if missing
        if ! command -v grep &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}grep not found, installing...\033[0m"
            pkg install grep -y
        fi
    else
        # For Linux environments (Debian/Ubuntu or RedHat-based)
        echo -e "${BrightWhite}[${BrightGreen}*${BrightWhite}] ${BrightGreen}Detected Linux environment\033[0m"

        # Check for curl and install if missing
        if ! command -v curl &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}curl not found, installing...\033[0m"
            if [ -x "$(command -v apt-get)" ]; then
                sudo apt-get install curl -y
            elif [ -x "$(command -v yum)" ]; then
                sudo yum install curl -y
            else
                echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Package manager not found. Please install curl manually.\033[0m"
                exit 1
            fi
        fi
        
        # Check for grep and install if missing
        if ! command -v grep &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}grep not found, installing...\033[0m"
            if [ -x "$(command -v apt-get)" ]; then
                sudo apt-get install grep -y
            elif [ -x "$(command -v yum)" ]; then
                sudo yum install grep -y
            else
                echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Package manager not found. Please install grep manually.\033[0m"
                exit 1
            fi
        fi
    fi
}

install_dependencies

banner() {
 
    clear
    echo -e "\033[0m\033[92m\033[1m"
    cat << "EOF"
     
  _____ _____    ______ _           _           
 |_   _|  __ \  |  ____(_)         | |          
   | | | |  | | | |__   _ _ __   __| | ___ _ __ 
   | | | |  | | |  __| | | '_ \ / _` |/ _ \ '__|
  _| |_| |__| | | |    | | | | | (_| |  __/ |   
 |_____|_____/  |_|    |_|_| |_|\__,_|\___|_| 
   
                             Developer:Sreeraj         
                                                                                                                        
EOF
    echo -e "\033[0m\033[93m* Copyright © Sreeraj, 2024  *"
    echo -e "\033[93m* GitHub: https://github.com/s-r-e-e-r-a-j  *\033[0m"
    echo
 
 
 
}

partial() {

if [[ -e $username.txt ]]; then
printf "\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Saved:\e[0m\e[1;77m %s.txt\n" $username
fi

}


check_file() {
if [[ -e $username.txt ]]; then
printf "\e[1;92m[\e[0m\e[1;77mx\e[0m\e[1;92m] Removing previous file:\e[0m\e[1;77m %s.txt" $username
printf "\n\n"
rm -rf $username.txt
else
printf "\n"
fi

}


scanner() {

printf "\e[1;92m[\e[0m\e[1;77m>\e[0m\e[1;92m] Checking username\e[0m\e[1;77m %s\e[0m\e[1;92m on social networks: \e[0m\n" $username

## INSTAGRAM

check_insta=$(curl -s -H "Accept-Language: en" "https://www.instagram.com/$username" -L | grep -o 'The link you followed may be broken'; echo $?)
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Instagram: \e[0m"

if [[ $check_insta == *'1'* ]]; then
printf "\e[1;92m Found!\e[0m https://www.instagram.com/%s\n" $username
printf "https://www.instagram.com/%s\n" $username > $username.txt
elif [[ $check_insta == *'0'* ]]; then
printf "\e[1;93mNot Found!\e[0m\n"
fi

## Facebook

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Facebook: \e[0m"
check_face=$(curl -s "https://www.facebook.com/$username" -L -H "Accept-Language: en" | grep -o 'not found'; echo $?)


if [[ $check_face == *'1'* ]]; then
printf "\e[1;92m Found!\e[0m https://www.facebook.com/%s\n" $username
printf "https://www.facebook.com/%s\n" $username >> $username.txt
elif [[ $check_face == *'0'* ]]; then
printf "\e[1;93mNot Found!\e[0m\n"
fi


## X (formerly Twitter)

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] X (Twitter): \e[0m"
check1=$(curl -s -i "https://x.com/$username" -H "Accept-Language: en" -L | grep -o 'page doesnâ€™t exist\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://x.com/%s\n" $username
printf "https://x.com/%s\n" $username >> $username.txt
fi

## GitLab

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] GitLab: \e[0m"
check1=$(curl -s -i "https://gitlab.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://gitlab.com/%s\n" $username
printf "https://gitlab.com/%s\n" $username >> $username.txt
fi


## Snapchat

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Snapchat: \e[0m"
check1=$(curl -s -i "https://www.snapchat.com/add/$username" -H "Accept-Language: en" -L | grep -o 'page doesnâ€™t exist\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.snapchat.com/add/%s\n" $username
printf "https://www.snapchat.com/add/%s\n" $username >> $username.txt
fi

## Buy Me a Coffee

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Buy Me a Coffee: \e[0m"
check1=$(curl -s -i "https://www.buymeacoffee.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.buymeacoffee.com/%s\n" $username
printf "https://www.buymeacoffee.com/%s\n" $username >> $username.txt
fi



## LinkedIn

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] LinkedIn: \e[0m"
check1=$(curl -s -i "https://www.linkedin.com/in/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.linkedin.com/in/%s\n" $username
printf "https://www.linkedin.com/in/%s\n" $username >> $username.txt
fi

## Telegram

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Telegram: \e[0m"
check1=$(curl -s -i "https://t.me/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://t.me/%s\n" $username
printf "https://t.me/%s\n" $username >> $username.txt
fi

## YOUTUBE

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] YouTube: \e[0m"
check_youtube=$(curl -s "https://www.youtube.com/$username" -L -H "Accept-Language: en" | grep -o 'Not Found'; echo $?)


if [[ $check_youtube == *'1'* ]]; then
printf "\e[1;92m Found!\e[0m https://www.youtube.com/%s\n" $username
printf "https://www.youtube.com/%s\n" $username >> $username.txt
elif [[ $check_youtube == *'0'* ]]; then
printf "\e[1;93mNot Found!\e[0m\n"
fi

## BLOGGER

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Blogger: \e[0m"
check=$(curl -s "https://$username.blogspot.com" -L -H "Accept-Language: en" -i | grep -o 'HTTP/2 404'; echo $?)


if [[ $check == *'1'* ]]; then
printf "\e[1;92m Found!\e[0m https://%s.blogspot.com\n" $username
printf "https://%s.blogspot.com\n" $username >> $username.txt
elif [[ $check == *'0'* ]]; then
printf "\e[1;93mNot Found!\e[0m\n"
fi

## GLOOGLE PLUS

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] GooglePlus: \e[0m"
check=$(curl -s "https://plus.google.com/+$username/posts" -L -H "Accept-Language: en" -i | grep -o 'HTTP/2 404' ; echo $?)


if [[ $check == *'1'* ]]; then
printf "\e[1;92m Found!\e[0m https://plus.google.com/+%s/posts\n" $username
printf "https://plus.google.com/+%s/posts\n" $username >> $username.txt
elif [[ $check == *'0'* ]]; then
printf "\e[1;93mNot Found!\e[0m\n"
fi

## REDDIT

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Reddit: \e[0m"
check1=$(curl -s -i "https://www.reddit.com/user/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | head -n1 | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.reddit.com/user/%s\n" $username
printf "https://www.reddit.com/user/%s\n" $username >> $username.txt
fi

## WORDPRESS

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Wordpress: \e[0m"
check1=$(curl -s -i "https://$username.wordpress.com" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'Do you want to register' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.wordpress.com\n" $username
printf "https://%s.wordpress.com\n" $username >> $username.txt
fi

## PINTEREST

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Pinterest: \e[0m"
check1=$(curl -s -i "https://www.pinterest.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '?show_error' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.pinterest.com/%s\n" $username
printf "https://www.pinterest.com/%s\n" $username >> $username.txt
fi

## GITHUB

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Github: \e[0m"
check1=$(curl -s -i "https://www.github.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.github.com/%s\n" $username
printf "https://www.github.com/%s\n" $username >> $username.txt
fi

## TUMBLR

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Tumblr: \e[0m"
check1=$(curl -s -i "https://$username.tumblr.com" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.tumblr.com\n" $username
printf "https://%s.tumblr.com\n" $username >> $username.txt
fi

## FLICKR

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Flickr: \e[0m"
check1=$(curl -s -i "https://www.flickr.com/people/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.flickr.com/photos/%s\n" $username
printf "https://www.flickr.com/photos/%s\n" $username >> $username.txt
fi

## STEAM

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Steam: \e[0m"
check1=$(curl -s -i "https://steamcommunity.com/id/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'The specified profile could not be found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://steamcommunity.com/id/%s\n" $username
printf "https://steamcommunity.com/id/%s\n" $username >> $username.txt
fi

## VIMEO

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Vimeo: \e[0m"
check1=$(curl -s -i "https://vimeo.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://vimeo.com/%s\n" $username
printf "https://vimeo.com/%s\n" $username >> $username.txt
fi


## SoundCloud

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] SoundCloud: \e[0m"
check1=$(curl -s -i "https://soundcloud.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '404 Not Found'; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://soundcloud.com/%s\n" $username
printf "https://soundcloud.com/%s\n" $username >> $username.txt
fi

## DISQUS

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Disqus: \e[0m"
check1=$(curl -s -i "https://disqus.com/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o '404 NOT FOUND' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://disqus.com/%s\n" $username
printf "https://disqus.com/%s\n" $username >> $username.txt
fi

## MEDIUM

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Medium: \e[0m"
check1=$(curl -s -i "https://medium.com/@$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://medium.com/@%s\n" $username
printf "https://medium.com/@%s\n" $username >> $username.txt
fi

## VK

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] VK: \e[0m"
check1=$(curl -s -i "https://vk.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://vk.com/%s\n" $username
printf "https://vk.com/%s\n" $username >> $username.txt
fi

## About.me

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] About.me: \e[0m"
check1=$(curl -s -i "https://about.me/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://about.me/%s\n" $username
printf "https://about.me/%s\n" $username >> $username.txt
fi

## Spotify

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Spotify: \e[0m"
check1=$(curl -s -i "https://open.spotify.com/user/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://open.spotify.com/user/%s\n" $username
printf "https://open.spotify.com/user/%s\n" $username >> $username.txt
fi

## MixCloud

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] MixCloud: \e[0m"
check1=$(curl -s -i "https://www.mixcloud.com/$username" -H "Accept-Language: en" -L | grep -o 'error-message' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.mixcloud.com/%s\n" $username
printf "https://www.mixcloud.com/%s\n" $username >> $username.txt
fi

## Scribd

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Scribd: \e[0m"
check1=$(curl -s -i "https://www.scribd.com/$username" -H "Accept-Language: en" -L | grep -o 'show_404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.scribd.com/%s\n" $username
printf "https://www.scribd.com/%s\n" $username >> $username.txt
fi

## Badoo

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Badoo: \e[0m"
check1=$(curl -s -i "https://www.badoo.com/en/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.badoo.com/en/%s\n" $username
printf "https://www.badoo.com/en/%s\n" $username >> $username.txt
fi

# Patreon

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Patreon: \e[0m"
check1=$(curl -s -i "https://www.patreon.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.patreon.com/%s\n" $username
printf "https://www.patreon.com/%s\n" $username >> $username.txt
fi

## BitBucket

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] BitBucket: \e[0m"
check1=$(curl -s -i "https://bitbucket.org/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://bitbucket.org/%s\n" $username
printf "https://bitbucket.org/%s\n" $username >> $username.txt
fi

## CashMe

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] CashMe: \e[0m"
check1=$(curl -s -i "https://cash.me/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found'; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://cash.me/%s\n" $username
printf "https://cash.me/%s\n" $username >> $username.txt
fi

## Behance

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Behance: \e[0m"
check1=$(curl -s -i "https://www.behance.net/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found'; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.behance.net/%s\n" $username
printf "https://www.behance.net/%s\n" $username >> $username.txt
fi

## Instructables

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Instructables: \e[0m"
check1=$(curl -s -i "https://www.instructables.com/member/$username" -H "Accept-Language: en" -L | grep -o '404 NOT FOUND' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.instructables.com/member/%s\n" $username
printf "https://www.instructables.com/member/%s\n" $username >> $username.txt
fi

## KeyBase

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Keybase: \e[0m"
check1=$(curl -s -i "https://keybase.io/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://keybase.io/%s\n" $username
printf "https://keybase.io/%s\n" $username >> $username.txt
fi

## Kongregate

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Kongregate: \e[0m"
check1=$(curl -s -i "https://kongregate.com/accounts/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://kongregate.com/accounts/%s\n" $username
printf "https://kongregate.com/accounts/%s\n" $username >> $username.txt
fi

## Livejournal

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] LiveJournal: \e[0m"
check1=$(curl -s -i "https://$username.livejournal.com" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.livejournal.com\n" $username
printf "https://%s.livejournal.com\n" $username >> $username.txt
fi

## AngelList

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] AngelList: \e[0m"
check1=$(curl -s -i "https://angel.co/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://angel.co/%s\n" $username
printf "https://angel.co/%s\n" $username >> $username.txt
fi

## Last.fm

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] last.fm: \e[0m"
check1=$(curl -s -i "https://last.fm/user/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://last.fm/user/%s\n" $username
printf "https://last.fm/user/%s\n" $username >> $username.txt
fi

## Dribbble

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Dribbble: \e[0m"
check1=$(curl -s -i "https://dribbble.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://dribbble.com/%s\n" $username
printf "https://dribbble.com/%s\n" $username >> $username.txt
fi

## Gravatar

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Gravatar: \e[0m"
check1=$(curl -s -i "https://en.gravatar.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://en.gravatar.com/%s\n" $username
printf "https://en.gravatar.com/%s\n" $username >> $username.txt
fi

## Pastebin

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Pastebin: \e[0m"
check1=$(curl -s -i "https://pastebin.com/u/$username" -H "Accept-Language: en" -L --user-agent '"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801"' | grep -o 'location: /index' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://pastebin.com/u/%s\n" $username
printf "https://pastebin.com/u/%s\n" $username >> $username.txt
fi

## Foursquare

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Foursquare: \e[0m"
check1=$(curl -s -i "https://foursquare.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://foursquare.com/%s\n" $username
printf "https://foursquare.com/%s\n" $username >> $username.txt
fi

## Roblox

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Roblox: \e[0m"
check1=$(curl -s -i "https://www.roblox.com/user.aspx?username=$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.roblox.com/user.aspx?username=%s\n" $username
  printf "https://www.roblox.com/user.aspx?username=%s\n" $username >> "$username.txt"
fi

## Gumroad

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Gumroad: \e[0m"
check1=$(curl -s -i "https://www.gumroad.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.gumroad.com/%s\n" $username
printf "https://www.gumroad.com/%s\n" $username >> $username.txt
fi

## Newgrounds

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Newgrounds: \e[0m"
check1=$(curl -s -i "https://$username.newgrounds.com" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404 ' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.newgrounds.com\n" $username
printf "https://%s.newgrounds.com\n" $username >> $username.txt
fi

## Wattpad

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Wattpad: \e[0m"
check1=$(curl -s -i "https://www.wattpad.com/user/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404 ' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.wattpad.com/user/%s\n" $username
printf "https://www.wattpad.com/user/%s\n" $username >> $username.txt
fi

## Canva

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Canva: \e[0m"
check1=$(curl -s -i "https://www.canva.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404 ' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.canva.com/%s\n" $username
printf "https://www.canva.com/%s\n" $username >> $username.txt
fi

## CreativeMarket

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] CreativeMarket: \e[0m"
check1=$(curl -s -i "https://creativemarket.com/$username" -H "Accept-Language: en" -L | grep -o '404eef72' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://creativemarket.com/%s\n" $username
printf "https://creativemarket.com/%s\n" $username >> $username.txt
fi


## 500px

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] 500px: \e[0m"
check1=$(curl -s -i "https://500px.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://500px.com/%s\n" $username
printf "https://500px.com/%s\n" $username >> $username.txt
fi

## Buzzfeed

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Buzzfeed: \e[0m"
check1=$(curl -s -i "https://buzzfeed.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://buzzfeed.com/%s\n" $username
printf "https://buzzfeed.com/%s\n" $username >> $username.txt
fi

## TripAdvisor

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] TripAdvisor: \e[0m"
check1=$(curl -s -i "https://tripadvisor.com/members/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://tripadvisor.com/members/%s\n" $username
printf "https://tripadvisor.com/members/%s\n" $username >> $username.txt
fi

## HubPages

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] HubPages: \e[0m"
check1=$(curl -s -i "https://$username.hubpages.com" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.hubpages.com/\n" $username
printf "https://%s.hubpages.com/\n" $username >> $username.txt
fi

## Contently

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Contently: \e[0m"
check1=$(curl -s -i "https://$username.contently.com" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.contently.com\n" $username
printf "https://%s.contently.com\n" $username >> $username.txt
fi

## Houzz

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Houzz: \e[0m"
check1=$(curl -s -i "https://houzz.com/user/$username" -H "Accept-Language: en" -L | grep -o 'an error has occurred' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://houzz.com/user/%s\n" $username
printf "https://houzz.com/user/%s\n" $username >> $username.txt
fi


## Wikipedia

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Wikipedia: \e[0m"
check1=$(curl -s -i "https://www.wikipedia.org/wiki/User:$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.wikipedia.org/wiki/User:%s\n" $username
printf "https://www.wikipedia.org/wiki/User:%s\n" $username >> $username.txt
fi

## HackerNews

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] HackerNews: \e[0m"
check1=$(curl -s -i "https://news.ycombinator.com/user?id=$username" -H "Accept-Language: en" -L | grep -o 'No such user' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://news.ycombinator.com/user?id=%s\n" $username
printf "https://news.ycombinator.com/user?id=%s\n" $username >> $username.txt
fi

## CodeMentor

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] CodeMentor: \e[0m"
check1=$(curl -s -i "https://www.codementor.io/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.codementor.io/%s\n" $username
printf "https://www.codementor.io/%s\n" $username >> $username.txt
fi

## ReverbNation

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] ReverbNation: \e[0m"
check1=$(curl -s -i "https://www.reverbnation.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.reverbnation.com/%s\n" $username
printf "https://www.reverbnation.com/%s\n" $username >> $username.txt
fi

## Designspiration 65

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Designspiration: \e[0m"
check1=$(curl -s -i "https://www.designspiration.net/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.designspiration.net/%s\n" $username
printf "https://www.designspiration.net/%s\n" $username >> $username.txt
fi

## Bandcamp

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Bandcamp: \e[0m"
check1=$(curl -s -i "https://www.bandcamp.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.bandcamp.com/%s\n" $username
printf "https://www.bandcamp.com/%s\n" $username >> $username.txt
fi


## ColourLovers

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] ColourLovers: \e[0m"
check1=$(curl -s -i "https://www.colourlovers.com/love/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.colourlovers.com/love/%s\n" $username
printf "https://www.colourlovers.com/love/%s\n" $username >> $username.txt
fi


## IFTTT

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] IFTTT: \e[0m"
check1=$(curl -s -i "https://www.ifttt.com/p/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.ifttt.com/p/%s\n" $username
printf "https://www.ifttt.com/p/%s\n" $username >> $username.txt
fi

## Ebay

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Ebay: \e[0m"
check1=$(curl -s -i "https://www.ebay.com/usr/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found\|eBay Profile - error' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.ebay.com/usr/%s\n" $username
printf "https://www.ebay.com/usr/%s\n" $username >> $username.txt
fi

## Slack

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Slack: \e[0m"
check1=$(curl -s -i "https://$username.slack.com" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.slack.com\n" $username
printf "https://%s.slack.com\n" $username >> $username.txt
fi

## OkCupid

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] OkCupid: \e[0m"
check1=$(curl -s -i "https://www.okcupid.com/profile/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.okcupid.com/profile/%s\n" $username
printf "https://www.okcupid.com/profile/%s\n" $username >> $username.txt
fi

## Trip

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Trip: \e[0m"
check1=$(curl -s -i "https://www.trip.skyscanner.com/user/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found\|HTTP/2 410' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.trip.skyscanner.com/user/%s\n" $username
printf "https://www.trip.skyscanner.com/user/%s\n" $username >> $username.txt
fi

## Ello

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Ello: \e[0m"
check1=$(curl -s -i "https://ello.co/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://ello.co/%s\n" $username
printf "https://ello.co/%s\n" $username >> $username.txt
fi


## Basecamp

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Basecamp: \e[0m"
check1=$(curl -s -i "https://$username.basecamphq.com/login" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404\|404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://%s.basecamphq.com/login\n" $username
printf "https://%s.basecamphq.com/login\n" $username >> $username.txt

fi



## Twitch

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Twitch: \e[0m"
check1=$(curl -s -i "https://www.twitch.tv/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.twitch.tv/%s\n" $username
printf "https://www.twitch.tv/%s\n" $username >> $username.txt
fi


## Stack Overflow

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Stack Overflow: \e[0m"
check1=$(curl -s -i "https://stackoverflow.com/users/$username" -H "Accept-Language: en" -L | grep -o 'Page Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://stackoverflow.com/users/%s\n" $username
printf "https://stackoverflow.com/users/%s\n" $username >> $username.txt
fi

## Venmo

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Venmo: \e[0m"
check1=$(curl -s -i "https://venmo.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://venmo.com/%s\n" $username
printf "https://venmo.com/%s\n" $username >> $username.txt
fi

## Fiverr

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Fiverr: \e[0m"
check1=$(curl -s -i "https://www.fiverr.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.fiverr.com/%s\n" $username
printf "https://www.fiverr.com/%s\n" $username >> $username.txt
fi

## DeviantArt

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] DeviantArt: \e[0m"
check1=$(curl -s -i "https://www.deviantart.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.deviantart.com/%s\n" $username
printf "https://www.deviantart.com/%s\n" $username >> $username.txt
fi

## Coursera

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Coursera: \e[0m"
check1=$(curl -s -i "https://www.coursera.org/user/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.coursera.org/user/%s\n" $username
printf "https://www.coursera.org/user/%s\n" $username >> $username.txt
fi


## Etsy

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Etsy: \e[0m"
check1=$(curl -s -i "https://www.etsy.com/shop/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.etsy.com/shop/%s\n" $username
printf "https://www.etsy.com/shop/%s\n" $username >> $username.txt
fi

## HackerRank

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] HackerRank: \e[0m"
check1=$(curl -s -i "https://www.hackerrank.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.hackerrank.com/%s\n" $username
printf "https://www.hackerrank.com/%s\n" $username >> $username.txt
fi

## Kaggle

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Kaggle: \e[0m"
check1=$(curl -s -i "https://www.kaggle.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.kaggle.com/%s\n" $username
printf "https://www.kaggle.com/%s\n" $username >> $username.txt
fi

## Flipboard

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Flipboard: \e[0m"
check1=$(curl -s -i "https://flipboard.com/@$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://flipboard.com/@%s\n" $username
printf "https://flipboard.com/@%s\n" $username >> $username.txt
fi

## Anghami

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Anghami: \e[0m"
check1=$(curl -s -i "https://www.anghami.com/profile/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.anghami.com/profile/%s\n" $username
printf "https://www.anghami.com/profile/%s\n" $username >> $username.txt
fi

## SoundClick

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] SoundClick: \e[0m"
check1=$(curl -s -i "https://www.soundclick.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.soundclick.com/%s\n" $username
printf "https://www.soundclick.com/%s\n" $username >> $username.txt
fi

## GoodGame

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] GoodGame: \e[0m"
check1=$(curl -s -i "https://goodgame.ru/channel/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://goodgame.ru/channel/%s\n" $username
printf "https://goodgame.ru/channel/%s\n" $username >> $username.txt
fi

## BandLab

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] BandLab: \e[0m"
check1=$(curl -s -i "https://www.bandlab.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.bandlab.com/%s\n" $username
printf "https://www.bandlab.com/%s\n" $username >> $username.txt
fi

## Notion

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Notion: \e[0m"
check1=$(curl -s -i "https://www.notion.so/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.notion.so/%s\n" $username
printf "https://www.notion.so/%s\n" $username >> $username.txt
fi

## Meetup

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Meetup: \e[0m"
check1=$(curl -s -i "https://www.meetup.com/members/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]] ; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.meetup.com/members/%s\n" $username
printf "https://www.meetup.com/members/%s\n" $username >> $username.txt
fi

## Unsplash

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Unsplash: \e[0m"
check1=$(curl -s -i "https://unsplash.com/@$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://unsplash.com/@%s\n" $username
printf "https://unsplash.com/@%s\n" $username >> $username.txt
fi


## Goodreads

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Goodreads: \e[0m"
check1=$(curl -s -i "https://www.goodreads.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.goodreads.com/%s\n" $username
printf "https://www.goodreads.com/%s\n" $username >> $username.txt
fi

## IndieHackers

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] IndieHackers: \e[0m"
check1=$(curl -s -i "https://www.indiehackers.com/@$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.indiehackers.com/@%s\n" $username
printf "https://www.indiehackers.com/@%s\n" $username >> $username.txt
fi

## Product Hunt

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Product Hunt: \e[0m"
check1=$(curl -s -i "https://www.producthunt.com/@$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.producthunt.com/@%s\n" $username
printf "https://www.producthunt.com/@%s\n" $username >> $username.txt
fi

## Academia.edu

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Academia.edu: \e[0m"
check1=$(curl -s -i "https://independent.academia.edu/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://independent.academia.edu/%s\n" $username
printf "https://independent.academia.edu/%s\n" $username >> $username.txt
fi

## Caffeine

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Caffeine: \e[0m"
check1=$(curl -s -i "https://www.caffeine.tv/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.caffeine.tv/%s\n" $username
printf "https://www.caffeine.tv/%s\n" $username >> $username.txt
fi

## OpenSea

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] OpenSea: \e[0m"
check1=$(curl -s -i "https://opensea.io/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://opensea.io/%s\n" $username
printf "https://opensea.io/%s\n" $username >> $username.txt
fi

## Substack

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Substack: \e[0m"
check1=$(curl -s -i "https://$username.substack.com" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://$username.substack.com\n" $username
printf "https://$username.substack.com\n" $username >> $username.txt
fi

## Anchor.fm

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Anchor.fm: \e[0m"
check1=$(curl -s -i "https://anchor.fm/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://anchor.fm/%s\n" $username
printf "https://anchor.fm/%s\n" $username >> $username.txt
fi

## VSCO

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] VSCO: \e[0m"
check1=$(curl -s -i "https://vsco.co/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://vsco.co/%s\n" $username
printf "https://vsco.co/%s\n" $username >> $username.txt
fi

## Letterboxd

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Letterboxd: \e[0m"
check1=$(curl -s -i "https://letterboxd.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://letterboxd.com/%s\n" $username
printf "https://letterboxd.com/%s\n" $username >> $username.txt
fi

## DLive

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] DLive: \e[0m"
check1=$(curl -s -i "https://dlive.tv/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://dlive.tv/%s\n" $username
printf "https://dlive.tv/%s\n" $username >> $username.txt
fi

## Mix.com

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Mix: \e[0m"
check1=$(curl -s -i "https://mix.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://mix.com/%s\n" $username
printf "https://mix.com/%s\n" $username >> $username.txt
fi

## Codecademy

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Codecademy: \e[0m"
check1=$(curl -s -i "https://www.codecademy.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.codecademy.com/%s\n" $username
printf "https://www.codecademy.com/%s\n" $username >> $username.txt
fi

## Discourse

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Discourse: \e[0m"
check1=$(curl -s -i "https://$username.discourse.org" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://$username.discourse.org\n" $username
printf "https://$username.discourse.org\n" $username >> $username.txt
fi

## Cloudflare

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Cloudflare: \e[0m"
check1=$(curl -s -i "https://$username.cloudflareaccess.com" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://$username.cloudflareaccess.com\n" $username
printf "https://$username.cloudflareaccess.com\n" $username >> $username.txt
fi


## Skillshare

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Skillshare: \e[0m"
check1=$(curl -s -i "https://www.skillshare.com/user/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.skillshare.com/user/%s\n" $username
printf "https://www.skillshare.com/user/%s\n" $username >> $username.txt
fi


## Plurk

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Plurk: \e[0m"
check1=$(curl -s -i "https://www.plurk.com/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.plurk.com/%s\n" $username
printf "https://www.plurk.com/%s\n" $username >> $username.txt
fi


## Periscope

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Periscope: \e[0m"
check1=$(curl -s -i "https://www.pscp.tv/$username" -H "Accept-Language: en" -L | grep -o 'HTTP/2 404' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.pscp.tv/%s\n" $username
printf "https://www.pscp.tv/%s\n" $username >> $username.txt
fi
## Epic Games

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Epic Games: \e[0m"
check1=$(curl -s -i "https://www.epicgames.com/id/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.epicgames.com/id/%s\n" $username
printf "https://www.epicgames.com/id/%s\n" $username >> $username.txt
fi

## Quora

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Quora: \e[0m"
check1=$(curl -s -i "https://www.quora.com/profile/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.quora.com/profile/%s\n" $username
printf "https://www.quora.com/profile/%s\n" $username >> $username.txt
fi

## Eventbrite

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Eventbrite: \e[0m"
check1=$(curl -s -i "https://www.eventbrite.com/o/$username-1234567890" -H "Accept-Language: en" -L | grep -o '404 Not Found' ; echo $?)

if [[ $check1 == *'0'* ]]; then 
printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 

printf "\e[1;92m Found!\e[0m https://www.eventbrite.com/o/%s-1234567890\n" $username
printf "https://www.eventbrite.com/o/%s-1234567890\n" $username >> $username.txt
fi

## Replit

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Replit: \e[0m"
check1=$(curl -s -i "https://replit.com/@$username" -H "Accept-Language: en" -L | grep -o '404 Not Found'; echo $?)
if [[ $check1 == *'0'* ]]; then 
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 
  printf "\e[1;92m Found!\e[0m https://replit.com/@%s\n" $username
  printf "https://replit.com/@%s\n" $username >> "$username.txt"
fi

## CodePen

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] CodePen: \e[0m"
check1=$(curl -s -i "https://codepen.io/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found'; echo $?)
if [[ $check1 == *'0'* ]]; then 
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then 
  printf "\e[1;92m Found!\e[0m https://codepen.io/%s\n" $username
  printf "https://codepen.io/%s\n" $username >> "$username.txt"
fi

## WeHeartIt

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] WeHeartIt: \e[0m"
check1=$(curl -s -i "https://weheartit.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://weheartit.com/%s\n" $username
  printf "https://weheartit.com/%s\n" $username >> "$username.txt"
fi

## Dev.to

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Dev.to: \e[0m"
check1=$(curl -s -i "https://dev.to/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://dev.to/%s\n" $username
  printf "https://dev.to/%s\n" $username >> "$username.txt"
fi

## Peerlist

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Peerlist: \e[0m"
check1=$(curl -s -i "https://peerlist.io/$username" -H "Accept-Language: en" -L | grep -o 'Not Found'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://peerlist.io/%s\n" $username
  printf "https://peerlist.io/%s\n" $username >> "$username.txt"
fi

## Runkit

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Runkit: \e[0m"
check1=$(curl -s -i "https://runkit.com/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://runkit.com/%s\n" $username
  printf "https://runkit.com/%s\n" $username >> "$username.txt"
fi

## HackerOne

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] HackerOne: \e[0m"
check1=$(curl -s -i "https://hackerone.com/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://hackerone.com/%s\n" $username
  printf "https://hackerone.com/%s\n" $username >> "$username.txt"
fi

## Hashnode

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Hashnode: \e[0m"
check1=$(curl -s -i "https://hashnode.com/@$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://hashnode.com/@%s\n" $username
  printf "https://hashnode.com/@%s\n" $username >> "$username.txt"
fi

## Crowdin

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Crowdin: \e[0m"
check1=$(curl -s -i "https://crowdin.com/profile/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://crowdin.com/profile/%s\n" $username
  printf "https://crowdin.com/profile/%s\n" $username >> "$username.txt"
fi

## Itch.io

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Itch.io: \e[0m"
check1=$(curl -s -i "https://$username.itch.io" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://%s.itch.io\n" $username
  printf "https://%s.itch.io\n" $username >> "$username.txt"
fi

## StackExchange

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] StackExchange: \e[0m"
check1=$(curl -s -i "https://stackexchange.com/users/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://stackexchange.com/users/%s\n" $username
  printf "https://stackexchange.com/users/%s\n" $username >> "$username.txt"
fi

## Lichess

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Lichess: \e[0m"
check1=$(curl -s -i "https://lichess.org/@/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://lichess.org/@/%s\n" $username
  printf "https://lichess.org/@/%s\n" $username >> "$username.txt"
fi

## Strava

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Strava: \e[0m"
check1=$(curl -s -i "https://www.strava.com/athletes/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.strava.com/athletes/%s\n" $username
  printf "https://www.strava.com/athletes/%s\n" $username >> "$username.txt"
fi

## ResearchGate

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] ResearchGate: \e[0m"
check1=$(curl -s -i "https://www.researchgate.net/profile/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.researchgate.net/profile/%s\n" $username
  printf "https://www.researchgate.net/profile/%s\n" $username >> "$username.txt"
fi

## YouNow

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] YouNow: \e[0m"
check1=$(curl -s -i "https://www.younow.com/$username" -H "Accept-Language: en" -L | grep -o '404 Not Found'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.younow.com/%s\n" $username
  printf "https://www.younow.com/%s\n" $username >> "$username.txt"
fi

## Codewars

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Codewars: \e[0m"
check1=$(curl -s -i "https://www.codewars.com/users/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.codewars.com/users/%s\n" $username
  printf "https://www.codewars.com/users/%s\n" $username >> "$username.txt"
fi

## Dribbble Teams

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Dribbble Teams: \e[0m"
check1=$(curl -s -i "https://dribbble.com/teams/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://dribbble.com/teams/%s\n" $username
  printf "https://dribbble.com/teams/%s\n" $username >> "$username.txt"
fi


## Polywork

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Polywork: \e[0m"
check1=$(curl -s -i "https://www.polywork.com/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.polywork.com/%s\n" $username
  printf "https://www.polywork.com/%s\n" $username >> "$username.txt"
fi


## Behance Projects

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Behance Projects: \e[0m"
check1=$(curl -s -i "https://www.behance.net/$username/projects" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.behance.net/%s/projects\n" $username
  printf "https://www.behance.net/%s/projects\n" $username >> "$username.txt"
fi

## Linktree

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Linktree: \e[0m"
check1=$(curl -s -i "https://linktr.ee/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://linktr.ee/%s\n" $username
  printf "https://linktr.ee/%s\n" $username >> "$username.txt"
fi



## Devpost

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Devpost: \e[0m"
check1=$(curl -s -i "https://devpost.com/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://devpost.com/%s\n" $username
  printf "https://devpost.com/%s\n" $username >> "$username.txt"
fi

## Rarible

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Rarible: \e[0m"
check1=$(curl -s -i "https://rarible.com/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://rarible.com/%s\n" $username
  printf "https://rarible.com/%s\n" $username >> "$username.txt"
fi


## ShutterStock

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] ShutterStock: \e[0m"
check1=$(curl -s -i "https://www.shutterstock.com/g/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.shutterstock.com/g/%s\n" $username
  printf "https://www.shutterstock.com/g/%s\n" $username >> "$username.txt"
fi

## ArtStation

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] ArtStation: \e[0m"
check1=$(curl -s -i "https://www.artstation.com/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.artstation.com/%s\n" $username
  printf "https://www.artstation.com/%s\n" $username >> "$username.txt"
fi

## StackShare

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] StackShare: \e[0m"
check1=$(curl -s -i "https://stackshare.io/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://stackshare.io/%s\n" $username
  printf "https://stackshare.io/%s\n" $username >> "$username.txt"
fi

## HeroForge

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] HeroForge: \e[0m"
check1=$(curl -s -i "https://www.heroforge.com/profile/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.heroforge.com/profile/%s\n" $username
  printf "https://www.heroforge.com/profile/%s\n" $username >> "$username.txt"
fi

## CodeChef

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] CodeChef: \e[0m"
check1=$(curl -s -i "https://www.codechef.com/users/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://www.codechef.com/users/%s\n" $username
  printf "https://www.codechef.com/users/%s\n" $username >> "$username.txt"
fi

## LeetCode

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] LeetCode: \e[0m"
check1=$(curl -s -i "https://leetcode.com/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://leetcode.com/%s\n" $username
  printf "https://leetcode.com/%s\n" $username >> "$username.txt"
fi

## AO3 (Archive of Our Own)

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] AO3: \e[0m"
check1=$(curl -s -i "https://archiveofourown.org/users/$username" -H "Accept-Language: en" -L | grep -o '404'; echo $?)
if [[ $check1 == *'0'* ]]; then
  printf "\e[1;93mNot Found!\e[0m\n"
elif [[ $check1 == *'1'* ]]; then
  printf "\e[1;92m Found!\e[0m https://archiveofourown.org/users/%s\n" $username
  printf "https://archiveofourown.org/users/%s\n" $username >> "$username.txt"
fi

partial
}
banner
read -p $'\e[1;92m[\e[0m\e[1;77m>\e[0m\e[1;92m] Input Username:\e[0m ' username
check_file
scanner
