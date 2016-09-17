cp wooddumper_slot2.nds wooddumper_dsi.nds
cp wooddumper_slot2.nds wooddumper_dsi_nogba.nds

$DEVKITARM/bin/ndstool -x default_arm7_wood.nds -7 default_arm7.bin 

$DEVKITARM/bin/dlditool dldi/dsisd.dldi wooddumper_dsi.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi wooddumper_dsi_nogba.nds

python patch_ndsheader_dsiware.py --title "WOODDUMPER" --maker 01 --code KWDE --mode dsi --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 wooddumper_dsi.nds

python patch_ndsheader_dsiware.py --title "WOODDUMPER" --maker 01 --code KWDE --mode dsinogba --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 wooddumper_dsi_nogba.nds

python patch_ndsheader_dsiware.py --read wooddumper_slot2.nds > wooddumper_slot2.nds_header.txt

python patch_ndsheader_dsiware.py --read wooddumper_dsi.nds > wooddumper_dsi.nds_header.txt

python patch_ndsheader_dsiware.py --read default_arm7_wood.nds > default_arm7.txt

./make_cia --srl=wooddumper_dsi.nds

cp libfatdir.nds libfatdir_dsisd_dldi.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi libfatdir_dsisd_dldi.nds

python patch_ndsheader_dsiware.py --title "LIBFATTEST" --maker 01 --code KFAE --mode dsi --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 libfatdir_dsisd_dldi.nds
python patch_ndsheader_dsiware.py --title "LIBFATTEST" --maker 01 --code KFAE --mode dsi --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 libfatdir.nds

cp dldi_tester.nds dldi_tester_dsisd_dldi.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dld dldi_tester_dsisd_dldi.nds

python patch_ndsheader_dsiware.py --title "DLDITEST" --maker 01 --code KDLE --mode dsi --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 dldi_tester_dsisd_dldi.nds

cp default_arm7_wood.nds test_cpu_speed.nds

python patch_ndsheader_dsiware.py  --title "TEST CPU SPEED" --maker 01 --code AFFE test_cpu_speed.nds

./make_cia --srl=test_cpu_speed.nds

cp NDS_Backup_Tool_Slot2.nds NDS_Backup_Tool_dsi.nds
cp NDS_Backup_Tool_Slot2.nds NDS_Backup_Tool_dsi_nogba.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi NDS_Backup_Tool_dsi.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi NDS_Backup_Tool_dsi_nogba.nds

python patch_ndsheader_dsiware.py --title "BACKUP" --maker 01 --code KBTE --mode dsi --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 NDS_Backup_Tool_dsi.nds

python patch_ndsheader_dsiware.py --title "BACKUP" --maker 01 --code KBTE --mode dsinogba --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 NDS_Backup_Tool_dsi_nogba.nds

./make_cia --srl=NDS_Backup_Tool_dsi.nds
./make_cia --srl=NDS_Backup_Tool_dsi_nogba.nds


cp powder.nds powder_dsi.nds
cp powder.nds powder_dsi_nogba.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi powder_dsi.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi powder_dsi_nogba.nds

python patch_ndsheader_dsiware.py --title "BACKUP" --maker 01 --code KBTE --mode dsi --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 powder_dsi.nds

python patch_ndsheader_dsiware.py --title "BACKUP" --maker 01 --code KBTE --mode dsinogba --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 powder_dsi_nogba.nds

./make_cia --srl=powder_dsi.nds


cp diggerds.nds diggerds_dsi.nds
cp diggerds.nds diggerds_dsi_nogba.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi diggerds_dsi.nds

$DEVKITARM/bin/dlditool dldi/dsisd.dldi diggerds_dsi_nogba.nds

python patch_ndsheader_dsiware.py --title "BACKUP" --maker 01 --code KBTE --mode dsi --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 diggerds_dsi.nds

python patch_ndsheader_dsiware.py --title "BACKUP" --maker 01 --code KBTE --mode dsinogba --arm7 default_arm7.bin --arm7EntryAddress 0x2380000 diggerds_dsi_nogba.nds

./make_cia --srl=diggerds_dsi.nds