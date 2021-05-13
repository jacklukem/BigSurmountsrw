display dialog " Welcome to the BigSur System snapshot rw mounter 

briefly description:

- Choose a disk to locate your BigSur System (also works if booting through external USB Big Sur)

- Select a Big Sur System (not its snapshot diskXs5s1) from the list that you want to mount as rw" with icon note
set alldisks to paragraphs of (do shell script "diskutil list")
set nonbootnumber to (count of alldisks)
try
	set alldisks to items 2 thru nonbootnumber of alldisks
	activate
	set your_selected_device_id to (choose from list alldisks with prompt "Please choose the Big Sur System volume to be mounted as rw

select with cursor and wait few seconds to highlight volume labels, then click OK to proceed")
	repeat with the_Item in your_selected_device_id
		set the_ID to (do shell script "diskutil list | grep -m 1" & space & quoted form of the_Item & space & "| grep -o 'disk[0-9][a-z][0-9]*'")
		set Check to false
		set tName to your_selected_device_id as text
		if tName contains "5:" and tName contains "APFS" and tName does not contain "VM" and tName does not contain "Data" then
			set Check to true
		end if
		if Check is true then
			try
				do shell script "mount -o nobrowse -t apfs /dev/" & the_ID & " /System/Volumes/Update/mnt1" with administrator privileges
				do shell script "open /System/Volumes/Update/mnt1/"
				display dialog "Big Sur system mounted as rw, opening current path from where you can now make any System modifications (for example patching kext and frameworks binaries)
				
- When ready click rebuild kc button to fix permissions making a new modified snapshot

- Rebuild KC can take up to 5 minutes to complete

- Don't close its app dock icon, when completes it shows a log (to check eventual errors) and notification message" with icon note buttons {"Rebuild KC", "Exit"} default button 1
				if button returned of result is "Rebuild KC" then set theresult to do shell script "chown -R 0:0 /System/Volumes/Update/mnt1/System/Library/Extensions ; chmod -R 755 /System/Volumes/Update/mnt1/System/Library/Extensions ; kmutil install --volume-root /System/Volumes/Update/mnt1/ --update-all ; bless --folder /System/Volumes/Update/mnt1/System/Library/CoreServices --bootefi --create-snapshot " with administrator privileges
				display alert theresult
			on error the error_message number the error_number
				display dialog "Error: " & the error_number & ". " & the error_message buttons {"OK"} default button 1
				quit
			end try
			do shell script "diskutil unmount /System/Volumes/Update/mnt1"
			display dialog "The Big Sur System has been modified, reboot to verify the changes" buttons {"Exit"} default button 1 with icon note
		else
			display dialog "You haven't selected any Big Sur System" buttons {"Exit"} with icon note
		end if
		
	end repeat
on error the error_message number the error_number
	if the error_number is -128 or the error_number is -1708 then
	else
		display dialog "There are no selected Big Sur system snapshots." buttons {"OK"} default button 1 with icon note
	end if
end try
