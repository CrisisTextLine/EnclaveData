#!/bin/bash

touch keys.tar

function go() {
	ssh-keygen -f $O.$1 -N '' -q
	PUBKEY=`ssh-keygen -y -f $O.$1`
	sed -i'' -s 's#"'$1'"#"'$1'"\n        pub_key: "'"$PUBKEY"'"#' ../EnclaveData/ansible/$O-data-node.yml
	tar --append --file=keys.tar $O.$1
}

O=app-state
go jennifer
go maggie
go will
go laura

O=basel
go miriam
go daria

O=berkeley
go adrian
go orianna

O=black-dog
go mark

O=brain
go rebekah

O=cornell
go cristian
go justine

O=georgia-tech
go munmun
go eva

O=kempe
go laura

O=montana
go ryan
go kim

O=northwestern
go james
go chenny

O=ryerson
go eric
go zachary
go jordan

O=stanford-ess
go marshall
go patrick

O=upenn
go kokil
go jen
go lyle

O=ut-austin
go hannah
go victor

O=virginia-tech
go stephen
go dana
