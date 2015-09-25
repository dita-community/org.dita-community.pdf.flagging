# org.dita-community.pdf.flagging
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

Tested with OT 1.8.5. Should work with 2.1 (if you try it and it doesn't work
please log an issue on GitHub: https://github.com/dita-community/org.dita-community.pdf.flagging/issues).
