PDF Flagging Patch for DITA OT 1.8.5
====================================

The PDF flagging plugin depends on an preprocessing extension
point that was added to the PDF2 plugin in 2.x Open Toolkit but is not
present in the 1.8.5 Toolkit. It would be in a 1.8.6 release
were anyone to make one but that seems unlikely.

However, you can safely patch the 1.8.5 OT to add this 
extension point by copying the files in the plugins/org.dita.pdf2
directory in this patch in place of the same files in your 1.8.5 OT.

This patch defines and implements a new extension point for the PDF2 plugin. It 
will not affect any existing extensions to the PDF2 plugin but will allow the 
PDF flagging plugin to work with the 1.8.5 OT. 