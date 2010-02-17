#!/bin/sh
#
# $FreeBSD: ports/net-mgmt/mrtg/files/mrtg_daemon.in,v 1.1 2008/06/06 02:57:04 lippe Exp $

#
# PROVIDE: mrtg_daemon
# REQUIRE: DAEMON bsnmpd snmpd

. /etc/rc.subr


name="mrtg_daemon"
rcvar=`set_rcvar`

load_rc_config $name

: ${mrtg_daemon_enable="YES"}
: ${mrtg_daemon_pidfile="/var/mrtg.pid"}
: ${mrtg_daemon_user="mrtg"}
: ${mrtg_daemon_group="mrtg"}
: ${mrtg_daemon_config="/usr/local/etc/mrtg/mrtg.cfg"}

: ${mrtg_daemon_flags="--pid-file $mrtg_daemon_pidfile --lock-file /var/lockfile --confcache-file /var/run/mrtg/confcache --user $mrtg_daemon_user --group $mrtg_daemon_group --daemon $mrtg_daemon_config"}

start_precmd="mrtg_daemon_precmd"

command="/usr/local/bin/mrtg"
command_interpreter="/usr/local/bin/perl"
pidfile=${mrtg_daemon_pidfile}

mrtg_daemon_precmd()
{
       rm -f /var/run/mrtg/lockfile /var/run/mrtg/confcache $mrtg_daemon_pidfile
       export LANG=C
}

run_rc_command "$1"
