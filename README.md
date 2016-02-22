PDF Revision and Status Flagging Extensions
===========================================

This plugin provides two extensions to the base PDF flagging
functionality:

1. Implements revision marking at the topic level such that when topic
elements have @rev and that revision is configured to have a revision
bar (via DITAVAL), the entire topic will get a revision bar and the
topic's entry in the ToC will also get a revision bar.

2. Elements with @status attributes are flagged as for normal change
tracking highlighting when the flagStatusValues Ant parameter is set
to "true" (it is off by default). When set to true, elements with @status values 
are highlighted green for "added", blue for "changed", and red with strikethrough
for "deleted".

This plugin works with the out-of-the-box 2.x version of the Open Toolkit.

To use it with the 1.8.5 Open Toolkit you must apply the patch provided
in the dita-ot-1.8.5-patch directory in this project (requires replacing
two files in the PDF2 plugin).

