#!/bin/bash
clear
# 1APT check
function apt_updates(){
	sudo apt update
	sudo apt-get check
	echo "does it all look good?"
	echo
        echo
}
# 2apt upgrade download only
function apt_downupgrade(){
        sudo apt upgrade --no-download
        echo
        echo
}

# 3apt upgrade
function apt_upgrade(){
        sudo apt upgrade
        echo
        echo
}

# 4APT clean
function apt_clean(){
	sudo apt autoclean
	echo
        echo
	}
	
# 5APT autoremove
function apt_remove(){
		sudo apt autoremove
		echo
        echo
}

# 6apt full upgrade
function apt_fullupgrade(){
        sudo apt full-upgrade --no-download
        echo
        echo
}


# 7Flatpak update
function flatpack_update(){
	sudo flatpak update --assumeyes
	echo
        echo
}

# Remove old Flatpaks and clean cahce folder
function flatpack_clean(){
	sudo flatpak uninstall --unused
	sudo rm -rfv /var/tmp/flatpak-cache-*
}

# Options to select from
options[0]="ALL updates LISTED"
options[1]="Apt repo updates"
options[2]="download updated packages only packages"
options[3]="update packages"
options[4]="APT autoclean ( clears old local apt files)"
options[5]="apt auto remove"
options[6]="apt full upgrade ( you need to redo any custom drivers like wifi"
options[7]="apt repo update and download packages"
options[8]="update repo get packages and upgrade packages (no full upgrade)"
options[9]="Quit (do not update anything)"

echo -e "Hello to updates!"
echo -e "Every option will require root password ('sudo')!\n"

# Display all options
for option in ${!options[@]}; do
  echo "[$option] - ${options[$option]}"
done


# Check for passed parameter to run automatically
# if no parameter, then ask and wait.
if [ -z "$1" ];
then
     # Wait for user response
     read -p "9Which options should be executed?: " selectedOption
else
     # pass parameter to selected option
     selectedOption="$1"
fi


# Exit?
if [ $selectedOption -eq 9 ]
then
  echo -e "\nNo updates selected, good bye!\n"
  exit
fi

echo -e "Executing ${options[$selectedOption]}\n"

# Run predefined functions
case $selectedOption in
        0)
                apt_updates
                apt_downupgrade
                apt_upgrade
                apt_clean
                apt_remove
                apt_fullupgrade
                flatpack_update
                flatpack_clean
                ;;
        1)
               	apt_updates
               	;;
        2)
                apt_downupgrade
                ;;
        3)
                apt_upgrade
                ;;
        4)
                apt_clean
                ;;
        5)
                apt_remove
                ;;

        6)
                apt_fullupgrade
                ;;

        7)
                apt_updates
				apt_downupgrade
                ;;
		8)
                apt_updates
				apt_downupgrade
				apt_upgrade
                ;;
  		     
               
esac

# done
echo -e "\nExecuted ${options[$selectedOption]}\nlooks good? restarting!"
sleep 10s
exec $0
