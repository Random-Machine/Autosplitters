# Watch_Dogs Autosplitter
## Installation
In the LiveSplit splits editor, make sure your game is set to Watch_Dogs and then click the "Activate" button. The ctOS control centers can be made to split in settings. By default, they are disabled. 

**Do not turn off subtitles in the game. That will probably prevent the lineid variable from working and disable autostart/autoreset functionality.**

Go to https://discord.gg/652nEqt if you have any questions.

## How it Works
**Ending splits still have to be done manually if you are doing a fullgame run.** The autosplitter should split whenever the mission counter in Act 1, 2, 3, or 4 goes up **(Aiden's story only).** For most missions, this will be after the mission complete text has shown up and dissapeared. Some missions like Collateral in Act 2 will split earlier because those missions increase their mission counter quicker. 

**The autosplitter will not currently split for They Can't Hide (potential crime intro), Foresight (gun shop act 1), Tools of the Trade (pawn shop act 2) or the graveyard cutscene in Act 1 (Remember).**

For Bad Blood, the XP reward of each main mission is used to split rather than the mission counter. The ending split still has to be done manually as well. 

The XP reward is also used to split for the Wards ctOS control center if it is selected under settings.

Lineid and the stopwatch variable are used for autostarting. It should start in the middle of when Maurice says "I don't know!" at the start of the main game. The stopwatch waits 0.3 seconds before allowing the splits to start automatically. For Bad Blood, it starts when T-bone says his first line when you gain control of him. 

Lineid is used to split for 3 of the ctOS centers (Brandon Docks, Mad Mile, Pawnee) if they are selected under settings. It is also used to split for Remember if it is selected under settings. 

Since the hash of disrupt_b64.dll is different between versions, it is calculated and used to determine version differences. 

Double split prevention is done using the isNotDoubleSplit function. It should prevent any double splits done by the autosplitter within 20 seconds. 

The reset function works by using the lineid of one of Aiden's lines before the starting lineid. 

## Supported Versions
* v1.04.497
* v1.06.329 - Steam Latest Update
* v1.06.329 - Uplay Latest Update
* *v1.06.329 - Epic Latest Update? (May work if it shares the same disrupt_b64.dll file as Steam or Uplay, but it's not tested).*

## How Memory Values were Found

### Mision Counter (Main Game/Aiden's Story)
The mission counters in this game are displayed in the progression menu, and each Act has their own mission counter.

#### Act 1
1.  Launch game. 
2.  Using Cheat Engine, attach the Watch_Dogs.exe process.
3.  Load save file into A1M6 (Thanks for the Tip). Scan for an exact value of 5 (4 byte) because we have 5 missions completed. Check "compare to first scan."
4.  Play until finishing A1M8 (A Wrench in the Works) and keep scanning next to match the Act 1 mission counter value after each mission has been completed (it will be 8 in the end).
5.  There should be one address left. Add it into the addresslist and right click it to pointer scan for this address. 
6.  Close game and keep Cheat Engine + the pointer scan menu open.
7.  Open game again and reattach the Watch_Dogs.exe process.
8.  Repeat steps 1-5 but rescan for any changes in the pointer scan menu using the new address.
9.  Repeat step 8. until you're confident in the pointer paths/they start barely changing. 
10. Choose a pointer path (Base module - most likely disrupt_b64.dll + offsets) in the pointer scan menu with the fewest offsets. Add that into your ASL script. 

#### Act 2
1.  Launch game. 
2.  Using Cheat Engine, attach the Watch_Dogs.exe process.
3.  Load save file into the end of A2M12 (A Risky Bid). Scan for an exact value of 11 (4 byte) because we have 11 missions completed. Check "compare to first scan."
4.  Play until finishing A2M14 (Planting a Bug) and keep scanning next to match the Act 2 mission counter value after each mission has been completed (it will be 14 in the end).
5.  There should be 6 addresses left unlike in Act 1. Add half of them into the addresslist and pointer scan each one. 
6.  Look for the pointer paths with disrupt_b64.dll and the same offset at the end between the different addresses. Those will probably work. Ideally, the base address will be the same as the Act 1 one.
7.  Choose a pointer path in the pointer scan menu with the fewest offsets. Add that into your ASL script. 

#### Act 3
1.  Launch game. 
2.  Using Cheat Engine, attach the Watch_Dogs.exe process.
3.  Load save file into the end of A3M3 (Unstoppable Force). Scan for an exact value of 2 (4 byte) because we have 2 missions completed. Check "compare to first scan."
4.  Play until finishing A3M5 (For the Portfolio) and keep scanning next to match the Act 3 mission counter value after each mission has been completed (it will be 5 in the end).
5.  There should be 6 addresses left unlike in Act 1. Add half of them into the addresslist and pointer scan each one. 
6.  Look for the pointer paths with disrupt_b64.dll and the same offset at the end between the different addresses. Those will probably work. Ideally, the base address will be the same as the Act 1 one.
7.  Choose a pointer path in the pointer scan menu with the fewest offsets. Add that into your ASL script. 

#### Act 4
1.  Launch game. 
2.  Using Cheat Engine, attach the Watch_Dogs.exe process.
3.  Load save file into the end of A4M4 (Defalt Condition). Scan for an exact value of 3 (4 byte) because we have 3 missions completed. Check "compare to first scan."
4.  Play until finishing A4M6 (Ghosts of the Past) and keep scanning next to match the Act 4 mission counter value after each mission has been completed (it will be 6 in the end).
5.  There should be 6 addresses left unlike in Act 1. Add half of them into the addresslist and pointer scan each one. 
6.  Look for the pointer paths with disrupt_b64.dll and the same offset at the end between the different addresses. Those will probably work. Ideally, the base address will be the same as the Act 1 one.
7.  Choose a pointer path in the pointer scan menu with the fewest offsets. Add that into your ASL script. 

### XP Counter
The XP memory values for the main game and Bad Blood are the same, but they are only used to split for Bad Blood currently.

#### v1.04.497
1. Launch game. 
2. Using Cheat Engine, attach the Watch_Dogs.exe process.
3. Load save file into beginning of A1M3 (Backstage Pass).
4. Scan for exact XP value that you have currently (4 byte). This can be found in the statistics menu. 
5. Kill a couple of enemies and scan for the exact value that your XP is increased to. There will probably be 20 values left. Check "compare to first scan."
6. Exit into the main menu and go back into the game. That will remove a couple of addresses. 
7. Add the first address on the list to your addresslist and pointer scan.
8. Close game.
9. Repeat steps 1-8 a few times to narrow down your pointer paths. Keep your pointer scan menu open to rescan the memory that you get in steps 5-7 each time. 
10. Pick a pointer path to add into your ASL script. 

#### v1.06.329
1. Launch game. 
2. Using Cheat Engine, attach the Watch_Dogs.exe process.
3. Load save file into beginning of Bad Blood A1M2 (Fading Signal).
4. Scan for exact XP value that you have currently (4 byte). This can be found in the statistics menu. Check "compare to first scan."
5. Kill a couple of enemies and scan for the exact value that your XP is increased to. There should only be one address left, so add this to the addresslist and pointer scan. 
6. Close game.
7. Repeat steps 1-6 three times to narrow down your pointer paths. Keep your pointer scan menu open to rescan the memory that you get in step 5 each time. 
8. Pick a pointer path to add into your ASL script. 

### Line ID
1. Decompiled strings were obtained from the WD modding community, and they contain the line id of every string used in the game. 
2. A line id can be searched in cheat engine when a specific line is said in the game. Look for the memory address that changes line ids after each line is said/shown. Add that to your addresslist and pointer scan. 
3. Repeat step 2 (Rescan once to narrow down on a lone pointer path with the last offset being 20). 
