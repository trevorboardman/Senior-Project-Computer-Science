#!/bin/bash

#lwcScript - For use with LWC Logging System 
#This code will be used on a Linux box or Raspberry Pi and read input from an RFID scanner
#Last Modified: 8/26/2019
#Copyright: 2019 by Trevor Boardman



# *************************************************************************************************************************************
# ***************************************************Warning***************************************************************************
# *************************************************************************************************************************************
	    #This script shall not be used without authorization and express permission from the developers.
		#Any attempt to implement, reuse, distribute, copy, or alter this code without permission from the developers is prohibited.
		#The developers will gladly assist you in any implementation of this program and it's affiliated components. 
# *************************************************************************************************************************************
# ***************************************************Warning***************************************************************************
# *************************************************************************************************************************************



#To Tailor This Script to Your Needs:
#Change all file paths to your own file paths: Sound Files, Room Files, sessionID File, Database auth files
#Change all ssh commands to connect to your server with the username that has RSA authorization
#You're good to go!

#If you are planning to implement this script and it's affiliated components, contact Trevor Boardman before attempting to do so.



# *************************************************************************************************************************************
# **************************************************Begin Script***********************************************************************
# *************************************************************************************************************************************


play -q /home/pi/LWC/startup.wav #change to file path of your sounds files
#Variable declaration
room1Session=false
room2Session=false
room3Session=false
room4Session=false
room5Session=false
room6Session=false
room7Session=false
room8Session=false

CounselorIDFound=false
ClientIDFound=false
RoomIDFound=false

sessionID=$(</home/pi/LWC/sessionID.txt) #Change to file path of your sessionID file
room1=$(</home/pi/LWC/Rooms/Room1.txt) #Change to file path of your Room files
room2=$(</home/pi/LWC/Rooms/Room2.txt) #Change to file path of your Room files
room3=$(</home/pi/LWC/Rooms/Room3.txt) #Change to file path of your Room files
room4=$(</home/pi/LWC/Rooms/Room4.txt) #Change to file path of your Room files
room5=$(</home/pi/LWC/Rooms/Room5.txt) #Change to file path of your Room files
room6=$(</home/pi/LWC/Rooms/Room6.txt) #Change to file path of your Room files
room7=$(</home/pi/LWC/Rooms/Room7.txt) #Change to file path of your Room files
room8=$(</home/pi/LWC/Rooms/Room8.txt) #Change to file path of your Room files
doorID=0
room1SessionID=0
room2SessionID=0
room3SessionID=0
room4SessionID=0
room5SessionID=0
room6SessionID=0
room7SessionID=0
room8SessionID=0
SECONDS=0

timer1=0
timer2=0
timer3=0
timer4=0
timer6=0
timer5=0
timer7=0
timer8=0
dbP=$(</home/pi/LWC/auth.txt) #Change to file path of your auth files
dbU=$(</home/pi/LWC/auth2.txt) #Change to file path of your auth files

cardCount=0
tempInput=0
CounselorID1=0
CounselorID=0
ClientID1=0
ClientID=0
tempCounselorID=0
tempClientID=0
temproomID=0

#Functions
#echo $CounselorID1
function findDoorID
{
	if [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room1" ] && [ "$tempInput" -ne "$temproomID" ]; then
		play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	elif [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room2" ] && [ "$tempInput" -ne "$temproomID" ]; then
	play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	elif [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room3" ] && [ "$tempInput" -ne "$temproomID" ]; then
	play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	elif [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room4" ] && [ "$tempInput" -ne "$temproomID" ]; then
	play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	elif [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room5" ] && [ "$tempInput" -ne "$temproomID" ]; then
	play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	elif [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room6" ] && [ "$tempInput" -ne "$temproomID" ]; then
	play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	elif [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room7" ] && [ "$tempInput" -ne "$temproomID" ]; then
	play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	elif [ "$RoomIDFound" = false ] && [ "$tempInput" -eq "$room8" ] && [ "$tempInput" -ne "$temproomID" ]; then
	play -q /home/pi/LWC/room.wav #Change to file path of your sound files
		temproomID=0
		return 0
	else
		return 1
	fi
}

# *************************************************************************************************************************************

function findClientID
{
	if [ "$ClientIDFound" = false ] && [ "$tempInput" -eq "$ClientID1" ] && [ "$tempInput" -ne "$tempClientID" ]; then
		play -q /home/pi/LWC/client.wav #Change to file path of your sound files
		tempClientID=0
		return 0
	else
		return 1
	fi
}

# *************************************************************************************************************************************

function findCounselorID
{
	if [ "$CounselorIDFound" = false ] && [ "$tempInput" -eq "$CounselorID1" ] && [ "$tempInput" -ne "$tempCounselorID" ]; then
		play -q /home/pi/LWC/counselor.wav #Change to file path of your sound files
		tempCounselorID=0
		return 0
	else
		return 1
	fi
}

# *************************************************************************************************************************************

function isSessionEnd
{
	if [ "$doorID" -eq "$room1" ] && [ "$room1Session" = true ] ; then
		break
	elif [ "$doorID" -eq "$room2" ] && [ "$room2Session" = true ] ; then
		break
	elif [ "$doorID" -eq "$room3" ] && [ "$room3Session" = true ] ; then
		break
	elif [ "$doorID" -eq "$room4" ] && [ "$room4Session" = true ] ; then
		break
	elif [ "$doorID" -eq "$room5" ] && [ "$room5Session" = true ] ; then
		break
	elif [ "$doorID" -eq "$room6" ] && [ "$room6Session" = true ] ; then
		break
	elif [ "$doorID" -eq "$room7" ] && [ "$room7Session" = true ] ; then
		break
	elif [ "$doorID" -eq "$room8" ] && [ "$room8Session" = true ] ; then
		break
	fi
}

# *************************************************************************************************************************************

#infinite loop
for ((;;))
do

	cardCount=0

	#Read input
	while [ "$cardCount" -lt 3 ]
	do
		read tempInput
		CounselorID1=$(ssh changeme "mysql -N -u $dbU -p$dbP LWC -e 'SELECT CounselorID FROM Counselor WHERE CounselorID='$tempInput';'") #change ssh username
		
		if [ -z "$CounselorID1" ] ; then
			CounselorID1=0
		fi

		ClientID1=$(ssh changeme "mysql -N -u $dbU -p$dbP LWC -e 'SELECT ClientID FROM Client WHERE ClientID='$tempInput';'") #change ssh username 

		if [ -z "$ClientID1" ] ; then
			ClientID1=0
		fi

		if findDoorID ; then
			
			doorID=$tempInput
			temproomID=$doorID

			RoomIDFound=true
			
			# Check to see if this door ID is to end the session
			isSessionEnd
			
		elif findCounselorID ; then 
			
			CounselorID=$tempInput
			tempCounselorID=$CounselorID

			CounselorIDFound=true
			
		elif findClientID ; then
			
			ClientID=$tempInput
			tempClientID=$ClientID
			
			ClientIDFound=true
			
		elif [ "$CounselorIDFound" = true ] && [ "$tempInput" -eq "$tempCounselorID" ]  ; then
			play -q /home/pi/LWC/already.wav #Change to file path of your sound files
			continue
			
		elif [ "$ClientIDFound" = true ] && [ "$tempInput" -eq "$tempClientID" ]  ; the
			play -q /home/pi/LWC/already.wav #Change to file path of your sound files
			continue
			
		elif [ "$RoomIDFound" = true ] && [ "$tempInput" -eq "$temproomID" ] ; then
			play -q /home/pi/LWC/already.wav #Change to file path of your sound files
			continue
			
	    else
			play -q /home/pi/LWC/again.wav #Change to file path of your sound files
			continue
			
		fi

		cardCount=$((cardCount+1))
	done
	temproomID=0
	tempCounselorID=0
	tempClientID=0
	CounselorIDFound=false
	ClientIDFound=false
	RoomIDFound=false
	########################################################################################################################################
	##################################################Session End Checks##################################################################
	########################################################################################################################################
	
	
	#Room 1 Session End	
	if [ "$room1Session" = true ] && [ "$doorID" -eq "$room1" ] ; then
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)" 

		#Starts timer 
		duration1=$((SECONDS - timer1)) 
		
		#Time math
		session1DurationHour=$((duration1 / 3600)) 
		session1DurationSecs=$((duration1 % 3600))
		session1DurationMins=$((session1DurationSecs / 60))            
		session1DurationSecs=$((session1DurationSecs % 60))
		
		# Add zero to beginning of single digit values for easier reading
		if [ "$session1DurationSecs" -lt 10 ] ; then
			session1DurationSecs="0$session1DurationSecs"
		elif [ "$session1DurationMins" -lt 10 ] ; then
			session1DurationMins="0$session1DurationMins"
		fi
		
		# Change duration to new format
		duration1="$session1DurationHour:$session1DurationMins:$session1DurationSecs"
		
		
		
		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration1\" WHERE sessionID = $room1SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
	    room1Session=false
	    
	#Rooms 2-8 are the same, just modified for each specific room
	
	#Room 2 Session End	
	elif [ "$room2Session" = true ] && [ "$doorID" -eq "$room2" ] ; then
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)"

		#Starts timer 
		duration2=$((SECONDS - timer2)) 

		#Time math
		session2DurationHour=$((duration2 / 3600)) 
		session2DurationSecs=$((duration2 % 3600))
		session2DurationMins=$((session2DurationSecs / 60))            
		session2DurationSecs=$((session2DurationSecs % 60))
		
		# Add zero to beginning of single digit values for easier reading
		if [ "$session2DurationSecs" -lt 10 ] ; then
			session2DurationSecs="0$session2DurationSecs"
		elif [ "$session2DurationMins" -lt 10 ] ; then
			session2DurationMins="0$session2DurationMins"
		fi
		
		# Change duration to new format
		duration2="$session2DurationHour:$session2DurationMins:$session2DurationSecs"

		ssh cahngeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration2\" WHERE sessionID = $room2SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
		room2Session=false
		
	#Room 3 Session End	
	elif [ "$room3Session" = true ] && [ "$doorID" -eq "$room3" ] ; then
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)"

		#Starts timer 
		duration3=$((SECONDS - timer3))

		#Time math
		session3DurationHour=$((duration3 / 3600)) 
		session3DurationSecs=$((duration3 % 3600))
		session3DurationMins=$((session3DurationSecs / 60))            
		session3DurationSecs=$((session3DurationSecs % 60))
		
		# Add zero to beginning of single digit values for easier reading
		if [ "$session3DurationSecs" -lt 10 ] ; then
			session3DurationSecs="0$session3DurationSecs"
		elif [ "$session3DurationMins" -lt 10 ] ; then
			session3DurationMins="0$session3DurationMins"
		fi
		
		# Change duration to new format
		duration3="$session3DurationHour:$session3DurationMins:$session3DurationSecs"

		

		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration3\" WHERE sessionID = $room3SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
		room3Session=false	
		
	#Room 4 Session End
	elif [ "$room4Session" = true ] && [ "$doorID" -eq "$room4" ] ; then
		
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)"

		#Starts timer 
		duration4=$((SECONDS - timer4)) 

		#Time math
		session4DurationHour=$((duration4 / 3600)) 
		session4DurationSecs=$((duration4 % 3600))
		session4DurationMins=$((session4DurationSecs / 60))            
		session4DurationSecs=$((session4DurationSecs % 60))
		
		# Add zero to beginning of single digit values for easier reading
		if [ "$session4DurationSecs" -lt 10 ] ; then
			session4DurationSecs="0$session4DurationSecs"
		elif [ "$session4DurationMins" -lt 10 ] ; then
			session4DurationMins="0$session4DurationMins"
		fi
		
		# Change duration to new format
		duration4="$session4DurationHour:$session4DurationMins:$session4DurationSecs"

		
		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration4\" WHERE sessionID = $room4SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
		room4Session=false	
		
	#Room 5 Session End
	elif [ "$room5Session" = true ] && [ "$doorID" -eq "$room5" ] ; then
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)"
		
		#Starts timer 
		duration5=$((SECONDS - timer5)) 
		
		#Time math
		session5DurationHour=$((duration5 / 3600)) 
		session5DurationSecs=$((duration5 % 3600))
		session5DurationMins=$((session5DurationSecs / 60))            
		session5DurationSecs=$((session5DurationSecs % 60))
		
		# Add zero to beginning of single digit values for easier reading
		if [ "$session5DurationSecs" -lt 10 ] ; then
			session5DurationSecs="0$session5DurationSecs"
		elif [ "$session5DurationMins" -lt 10 ] ; then
			session5DurationMins="0$session5DurationMins"
		fi
		
		# Change duration to new format
		duration5="$session5DurationHour:$session5DurationMins:$session5DurationSecs"
		
		

		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration5\" WHERE sessionID = $room5SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
		room5Session=false	
		
	#Room 6 Session End
	elif [ "$room6Session" = true ] && [ "$doorID" -eq "$room6" ] ; then
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)"

		#Starts timer 
		duration6=$((SECONDS - timer6)) 
		
		#Time math
		session6DurationHour=$((duration6 / 3600)) 
		session6DurationSecs=$((duration6 % 3600))
		session6DurationMins=$((session6DurationSecs / 60))            
		session6DurationSecs=$((session6DurationSecs % 60))
		
		# Add zero to beginning of single digit values for easier reading
		if [ "$session6DurationSecs" -lt 10 ] ; then
			session6DurationSecs="0$session6DurationSecs"
		elif [ "$session6DurationMins" -lt 10 ] ; then
			session6DurationMins="0$session6DurationMins"
		fi
		
		# Change duration to new format
		duration6="$session6DurationHour:$session6DurationMins:$session6DurationSecs"
		
		
		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration6\" WHERE sessionID = $room6SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
		room6Session=false	
		
	#Room 7 Session End
	elif [ "$room7Session" = true ] && [ "$doorID" -eq "$room7" ] ; then
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)"

		#Starts timer 
		duration7=$((SECONDS - timer7)) 

		#Time math
		session7DurationHour=$((duration7 / 3600)) 
		session7DurationSecs=$((duration7 % 3600))
		session7DurationMins=$((session7DurationSecs / 60))            
		session7DurationSecs=$((session7DurationSecs % 60))

		# Add zero to beginning of single digit values for easier reading
		if [ "$session7DurationSecs" -lt 10 ] ; then
			session7DurationSecs="0$session7DurationSecs"
		elif [ "$session7DurationMins" -lt 10 ] ; then
			session7DurationMins="0$session7DurationMins"
		fi
		
		# Change duration to new format
		duration7="$session7DurationHour:$session7DurationMins:$session7DurationSecs"

		
		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration7\" WHERE sessionID = $room7SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
		room7Session=false	
		
	#Room 8 Session End
	elif [ "$room8Session" = true ] && [ "$doorID" -eq "$room8" ] ; then
		
		#Sets end time for specific session
		sessionEndTime="$(date +%H.%M.%S)"

		#Starts timer 
		duration8=$((SECONDS - timer8)) 

		#Time math
		session8DurationHour=$((duration8 / 3600)) 
		session8DurationSecs=$((duration8 % 3600))
		session8DurationMins=$((session8DurationSecs / 60))            
		session8DurationSecs=$((session8DurationSecs % 60))
		
		# Add zero to beginning of single digit values for easier reading
		if [ "$session8DurationSecs" -lt 10 ] ; then
			session8DurationSecs="0$session8DurationSecs"
		elif [ "$session8DurationMins" -lt 10 ] ; then
			session8DurationMins="0$session8DurationMins"
		fi
		
		# Change duration to new format
		duration8="$session8DurationHour:$session8DurationMins:$session8DurationSecs"

		
		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'UPDATE CounselingLog SET SessionEnd = \"$sessionEndTime\", Duration = \"$duration8\" WHERE sessionID = $room8SessionID;'" #change ssh username
		play -q /home/pi/LWC/ended.wav #Change to file path of your sound files
		#Sets current session to false ending the session
		room8Session=false	
		
	########################################################################################################################################
	##################################################Session Start Checks##################################################################
	########################################################################################################################################
	
	#Room 1 Session Start
	
	#Checks if there is no current session in the specified room
	elif [ "$room1Session" = false ] && [ "$doorID" -eq "$room1" ] ; then   
		 
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"

		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)" 

		#Set timer variable back to 0
		timer1=$SECONDS

		#Increment session id
	    sessionID=$((sessionID+1))
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file

		#Set current room's session id to the current session id
		room1SessionID=$sessionID

		
		ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room1Session=true
        
	#Room 2 Session Start
	elif [ "$room2Session" = false ] && [ "$doorID" -eq "$room2" ] ; then
		 
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"
		
		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)"
		
		#Set timer variable back to 0
		timer2=$SECONDS

		#Increment session id
	    sessionID=$((sessionID+1))
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file

		#Set current room's session id to the current session id
		room2SessionID=$sessionID

		
	  	ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room2Session=true
    	
	#Room 3 Session Start
	 
	#Checks if there is no current session in the specified room
	elif [ "$room3Session" = false ] && [ "$doorID" -eq "$room3" ] ; then  
		 
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"
		
		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)" 

		#Set timer variable back to 0
		timer3=$SECONDS

		#Increment session id
	    sessionID=$((sessionID+1))
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file

		#Set current room's session id to the current session id
		room3SessionID=$sessionID

		
	  	ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room3Session=true
		
	#Room 4 Session Start
	
	#Checks if there is no current session in the specified room
	elif [ "$room4Session" = false ] && [ "$doorID" -eq "$room4" ] ; then  
		
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"
	
		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)" 

		#Set timer variable back to 0
		timer4=$SECONDS

		#Increment session id
	    sessionID=$((sessionID+1))
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file

		#Set current room's session id to the current session id
		room4SessionID=$sessionID

		
	  	ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		 play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room4Session=true
		
	#Room 5 Session Start
	 
	#Checks if there is no current session in the specified room
	elif [ "$room5Session" = false ] && [ "$doorID" -eq "$room5" ] ; then  
		 
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"

		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)" 
		
		#Set timer variable back to 0
		timer5=$SECONDS
		
		#Increment session id
	    sessionID=$((sessionID+1)) 
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file
		
		#Set current room's session id to the current session id
		room5SessionID=$sessionID
		
		
	  	
	  	ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room5Session=true
		
	#Room 6 Session Start
	
	#Checks if there is no current session in the specified room
	elif [ "$room6Session" = false ] && [ "$doorID" -eq "$room6" ] ; then  
		 
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"
		
		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)" 

		#Set timer variable back to 0
		timer6=$SECONDS

		#Increment session id
	    sessionID=$((sessionID+1))
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file

		#Set current room's session id to the current session id
		room6SessionID=$sessionID

		
	  	ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room6Session=true
		
	#Room 7 Session Start
	
	#Checks if there is no current session in the specified room
	elif [ "$room7Session" = false ] && [ "$doorID" -eq "$room7" ] ; then   
		 
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"
		
		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)" 

		#Set timer variable back to 0
		timer7=$SECONDS

		#Increment session id
	    sessionID=$((sessionID+1))
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file

		#Set current room's session id to the current session id
		room7SessionID=$sessionID

		

	  	ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room7Session=true
		
	#Room 8 Session Start
	
	#Checks if there is no current session in the specified room
	elif [ "$room8Session" = false ] && [ "$doorID" -eq "$room8" ] ; then   
		 
		# Make note of the date
		sessionDate="$(date +%m_%d_%y)"

		# Make note of the start time
		sessionStartTime="$(date +%H.%M.%S)" 

		#Set timer variable back to 0
		timer8=$SECONDS

		#Increment session id
	    sessionID=$((sessionID+1))
		echo $sessionID > /home/pi/LWC/sessionID.txt #Change to file path of your sessionID file

		#Set current room's session id to the current session id
		room8SessionID=$sessionID


	  	ssh changeme "mysql -u $dbU -p$dbP LWC -e 'INSERT INTO CounselingLog (sessionID, Room, CounselorID, ClientID, SessionStart, Date) VALUES ($sessionID,\"$doorID\",\"$CounselorID\",\"$ClientID\",\"$sessionStartTime\",\"$sessionDate\");'" #change ssh username
		play -q /home/pi/LWC/started.wav #Change to file path of your sound files
		#Sets current session to true beginning the session
		room8Session=true
		
	else
		continue
	fi

done
