nextcmd()
{
tail -n 1 mcs_output | grep -o docmd\([a-z]*\) | sed "s/docmd//" | sed "s/(//" | sed "s/)//"
}

docmds()
{
	while true; do 
		if [[ $(nextcmd) ]] ; then
			echo "say Doing command" $(nextcmd) "..." > mcs_pipe
			echo say $(./cmds/$(nextcmd)) > mcs_pipe
		fi;
		sleep 1;
	done
}


mkfifo mcs_pipe 
docmds &
tail -f mcs_pipe | java -jar minecraft_server.1.10.2.jar nogui > mcs_output
rm mcs_pipe
