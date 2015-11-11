#VoteProject
## build 
##
##I use nginx and uwsgi to build the website


###if you want to bulid to be a work website follow me

##
install nginx

		apt-get install nginx

then install uwsgi

	apt-get install uwsgi

mkdir in `sock` dir in `/var/www/` to save the socks
and change in `/etc/nginx/nginx.conf/` add this in http

		 access_log /var/www/log/nginx_access.log;
        error_log /var/www/log/nginx_error.log;
		 include /var/www/config/nginx/sites-enabled/*.conf;


and this will help you work uwsgi in `emperor`

###we decide to create folder for `emperor`

			sudo mkdir /var/www/config/nginx

this to save uwsgi's config file 

###we save log in `/var/www/log`

so

`sudo mkdir /var/www/log`

and we need create the two folder to manage the nginx config file

`sudo mkdir /var/www/config/nginx/sites-enabled`
`sudo mkdir /var/www/config/nginx/sites-available`


##but you need create a service file to manage the nginx 

so create a bash file in `/etc/init.d/nginx`

    #!/bin/sh
    
    ### BEGIN INIT INFO
    # Provides:   nginx
    # Required-Start:$local_fs $remote_fs $network $syslog $named
    # Required-Stop: $local_fs $remote_fs $network $syslog $named
    # Default-Stop:  0 1 6
    # Short-Description: starts the nginx web server
    # Description:   starts nginx using start-stop-daemon
    ### END INIT INFO
    
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
    DAEMON=/usr/sbin/nginx
    NAME=nginx
    DESC=nginx
    
    # Include nginx defaults if available
    if [ -r /etc/default/nginx ]; then
    . /etc/default/nginx
    fi
    
    test -x $DAEMON || exit 0
    . /lib/init/vars.sh
    . /lib/lsb/init-functions
    
    # Try to extract nginx pidfile
    PID=$(cat /etc/nginx/nginx.conf | grep -Ev '^\s*#' | awk 'BEGIN { RS="[;{}]" } { if ($1 == "pid") print $2 }' | head -n1)
    if [ -z "$PID" ]
    then
    PID=/run/nginx.pid
    fi
    
    # Check if the ULIMIT is set in /etc/default/nginx
    if [ -n "$ULIMIT" ]; then
    # Set the ulimits
    ulimit $ULIMIT
    fi
    
    #
    # Function that starts the daemon/service
    #
    do_start()
    {
    # Return
       #   0 if daemon has been started
    #   1 if daemon was already running
    #   2 if daemon could not be started
    start-stop-daemon --start --quiet --pidfile $PID --exec $DAEMON --test > /dev/null \
    || return 1
    start-stop-daemon --start --quiet --pidfile $PID --exec $DAEMON -- \
    $DAEMON_OPTS 2>/dev/null \
    || return 2
    }
    
    test_nginx_config() {
    $DAEMON -t $DAEMON_OPTS >/dev/null 2>&1
    }
    
    #
    # Function that stops the daemon/service
    #
    do_stop()
    {
    # Return
    #   0 if daemon has been stopped
    #   1 if daemon was already stopped
    #   2 if daemon could not be stopped
    #   other if a failure occurred
    start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PID --name $NAME
    RETVAL="$?"
    
    sleep 1
    return "$RETVAL"
    }
    
    #
    # Function that sends a SIGHUP to the daemon/service
    #
    do_reload() {
    start-stop-daemon --stop --signal HUP --quiet --pidfile $PID --name $NAME
    return 0
    }
    
    #
    # Rotate log files
    #
    do_rotate() {
    start-stop-daemon --stop --signal USR1 --quiet --pidfile $PID --name $NAME
    return 0
    }
    
    #
    # Online upgrade nginx executable
    #
    # "Upgrading Executable on the Fly"
    # http://nginx.org/en/docs/control.html
    #
    do_upgrade() {
    # Return
    #   0 if nginx has been successfully upgraded
    #   1 if nginx is not running
    #   2 if the pid files were not created on time
    #   3 if the old master could not be killed
    if start-stop-daemon --stop --signal USR2 --quiet --pidfile $PID --name $NAME; then
    # Wait for both old and new master to write their pid file
    while [ ! -s "${PID}.oldbin" ] || [ ! -s "${PID}" ]; do
    cnt=`expr $cnt + 1`
    if [ $cnt -gt 10 ]; then
    return 2
    fi
    sleep 1
    done
    # Everything is ready, gracefully stop the old master
    if start-stop-daemon --stop --signal QUIT --quiet --pidfile "${PID}.oldbin" --name $NAME; then
    return 0
    else
    return 3
    fi
    else
    return 1
    fi
    }
    
    case "$1" in
    start)
    [ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
    do_start
    case "$?" in
    0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
    2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
    esac
    ;;
    stop)
    [ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
    do_stop
    case "$?" in
    0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
    2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
    esac
    ;;
    restart)
    log_daemon_msg "Restarting $DESC" "$NAME"
    
    # Check configuration before stopping nginx
    if ! test_nginx_config; then
    log_end_msg 1 # Configuration error
    exit 0
    fi
    
    do_stop
    case "$?" in
    0|1)
    do_start
    case "$?" in
    0) log_end_msg 0 ;;
    1) log_end_msg 1 ;; # Old process is still running
    *) log_end_msg 1 ;; # Failed to start
    esac
    ;;
    *)
    # Failed to stop
    log_end_msg 1
    ;;
    esac
    ;;
    reload|force-reload)
    log_daemon_msg "Reloading $DESC configuration" "$NAME"
    
    # Check configuration before reload nginx
    #
    # This is not entirely correct since the on-disk nginx binary
    # may differ from the in-memory one, but that's not common.
    # We prefer to check the configuration and return an error
    # to the administrator.
    if ! test_nginx_config; then
    log_end_msg 1 # Configuration error
    exit 0
    fi
    
    do_reload
    log_end_msg $?
    ;;
    configtest|testconfig)
    log_daemon_msg "Testing $DESC configuration"
    test_nginx_config
    log_end_msg $?
    ;;
    status)
    status_of_proc -p $PID "$DAEMON" "$NAME" && exit 0 || exit $?
    ;;
    upgrade)
    log_daemon_msg "Upgrading binary" "$NAME"
    do_upgrade
    log_end_msg 0
    ;;
    rotate)
    log_daemon_msg "Re-opening $DESC log files" "$NAME"
    do_rotate
       log_end_msg $?
    ;;
    *)
    echo "Usage: $NAME {start|stop|restart|reload|force-reload|status|configtest|rotate|upgrade}" >&2
    exit 3
    ;;
    esac
    

		


## to start your project 
#### if you don't git clone the project do this

		cd /var/www/
		sudo mkdir vote
		cd vote
		sudo git clone https://github.com/MrZhangLoveLearning/votewebsite.git
		sudo chmod +x votewebsite/deploy.sh
		sudo ./votewebsite/deploy.sh


#### if you have clone it to local do that

		cd /var/vote/votewebsite
		git pull
		./deploy.sh






##API

####1 投票
url=/vote

args=id(ps:作品的id)

methods=GET or POST


####2 获取列表

url=/list

methods=GET or POST


return 
{
  "vote": 
  [{"id":1
    "path": "Ln22gnCe175492b35887dc2fb61e549bb8a0597512510089.png", 
    "voters": 1
    }
  ]
}

"1"-----作品id

"path"----作品的位置

"voters"----投票人数





