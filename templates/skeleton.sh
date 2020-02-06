#!/usr/bin/env bash

######################################################################
#
# Copyright (C) %YEAR% by %USER% <%MAIL%>
# All rights reserved.
#
######################################################################


######################################################################
#
# defaults:
#

#
MESSAGELEVEL="2"

#
EXITSTATUS="0"

#
APPS_PATH="${APPS_PATH:-$HOME/Apps}"

#
######################################################################


######################################################################
#
# handle exit status
#

#
AT_LEAST () {
	if test "${EXITSTATUS}" -lt "$1"
	then
		EXITSTATUS="$1"
	fi
}

#
EXIT () {
	exit "${EXITSTATUS}"
}

#
######################################################################


######################################################################
#
# common I/O routines:
#

#
MESSAGELABELS=( "DEBUG" "INFO " "WARN " "ERROR" "FATAL" )

#
PRINT () {
	local LEVEL="$1"
	shift
	if test "${LEVEL}" -ge "${MESSAGELEVEL}"
	then
		echo "[${MESSAGELABELS[${LEVEL}]}] $@"
	fi
}

#
DEBUG () {
	PRINT 0 "$@"
}

#
INFO () {
	PRINT 1 "$@"
}

#
WARN () {
	PRINT 2 "$@"
}

#
ERROR () {
	PRINT 3 "$@"
	AT_LEAST 1
}

#
FATAL () {
	PRINT 4 "$@"
	AT_LEAST 2
}

#
######################################################################


######################################################################
#
# parse command line:
#

#
set -- $(getopt	-o hvq			\
		-l help,verbose,quiet	\
		-- "$@" )
while true
do
	case "$1" in
	--help|-h)
		PRINT_HELP
		EXIT
		;;
	--verbose|-v)
		MESSAGELEVEL="1"
		shift
		;;
	--quiet|-q)
		MESSAGELEVEL="3"
		shift
		;;
	--)
		shift
		break
		;;
	*)
		FATAL "cannot understand this parameter: $1"
		EXIT
		;;
	esac
done

#
######################################################################


######################################################################
#
# bussiness logic:
#

#
for extra
do
	#
	# unquote extra
	eval extra=$extra
	#
	#
	FATAL "no se que hacer"
done

#
######################################################################


######################################################################
#
# The End
#

EXIT

#
######################################################################

