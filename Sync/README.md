Deploy only uses the git commands to download this project to the server manually or it can be the direction on wich the Webhook can call to do the same but automatically

It needs git on the server and this repository cloned, later you only update it from the online version

The two commands that are executed, checkout and pull are both bash files which contains the commands to download the project to the server
<br/>-Checkout will translate to git -C [route of the project] -f
<br/>-Pull will translate to git -C [route of the project] pull GameSystem HEAD, the reference for this project is the alias GameSystem and HEAD is the branch on the local repository, the one which is on [route of the project]

You may need to modify the apache config to allow shell_exec to run, in many cases it will be disabled or make sure apache has the right permissions to run that commands, in that case you can start the service/daemon with a user with enough permissions or using the sudo/runas commands before running the commands that need some permissions

So it get the proper command and stores on tmp, executed it and stores the output on output, the first command will not say anything but the second will say which and how many files has changed, if nothing has changed it will output the result from git, "Already up-to-date."
