system-config-printer # printer applet

#list printers
lpstat -p -d

#list supported options
lpoptions -p CanonMF4800 -l
=>
Resolution/Resolution : *600                                                                                     
CNDraftMode/Toner Save: True *False                                                                              
MediaType/Media Type : *PlainPaper PlainPaperL RECYCLED COLOR HEAVY1 HEAVY2 OHP LABELS ENVELOPE ROUGH1 ROUGH2 ROUGH3                                                                                                              
InputSlot/Paper Source: *Auto                                                                                    
OutputBin/Paper Destination: *Auto                                                                               
CNSpecialPrintMode/Special Print Adjustment: False Mode1 *Mode2 Mode3 Mode4                                      
Duplex/Duplex: *None DuplexNoTumble DuplexTumble                                                                 
BindEdge/BindingEdge: *Left Top                                                                                  
Collate/Collate: True *Group                                                                                     
CNHalftone/Halftones : Resolution *Gradation ColorTone                                                           
PageSize/Page Size: Letter Legal Statement Executive A5 B5 *A4 Monarch Com10 dl_envelope Envelope_C5 Index_3x5 16K
