#set DRAFT to the basename of draft xml file, i.e., <basename>.xml
DRAFT  = draft-ietf-rtgwg-ni-model
include ../Makefile.common

#make targets are:
# all	- Update trees mentioned in draft, <DRAFT>.{xml,txt,html,raw}
# idnits - Update <DRAFT>.txt, check it with idnits
# id	- create the -<rev> version of I-D in "IDs" subdirectory,
#	  also add to git
# rmid	- undo 'make id' (including git add)
# trees	- update .tree versions of modules mentioned in draft
# <DRAFT>.{xml,txt,html,raw} - update version of draft indicated by extension
# vars 	- for testing, shows some internal variables
