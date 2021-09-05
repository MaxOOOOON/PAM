#!/bin/bash

if groups $PAM_USER | grep -v admin ; then
   if [ $(date +%a) = "Sat"] || [ $(date +%a) = "Sun" ]; then 
      exit 1
    else 
      exit 0
  fi
fi


#gpasswd -d tecmint postgres delete from group

