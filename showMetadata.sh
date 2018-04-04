#!/bin/bash

digger () {
PADDRESS=$1;

for ENTRY in `curl -s $PADDRESS`;
        do
                LEN=$((${#ENTRY}-1));
                LC=${ENTRY:$LEN:1};
                if [ $LC == "/" ]; then
                        NEWPADDRESS=$PADDRESS$ENTRY;
                        digger $NEWPADDRESS
                else 
                        T=`echo $ENTRY | grep "0="`;
                        if [ ! -z $T ]; then
                                ENTRY="0/openssh-key";
                        fi;
                        LEAF="$PADDRESS$ENTRY";
                        CNAME=`echo $LEAF | sed -e 's/^.\{39\}//'`
                        echo "$CNAME: `curl -s $LEAF`";
                fi;
        done;
echo
PADDRESS=`echo $PADDRESS | sed -e 's/\/[^/]*\/$/\//g'`
}

digger http://169.254.169.254/latest/meta-data/

