state("Watch_Dogs" , "v1.04.497")
{int act1mainmissions1: "Disrupt_b64.dll", 0x3950830, 0xA8, 0x18, 0xC8, 0x18, 0x180, 0x98, 0xC24 ;
int act1mainmissions2: "Disrupt_b64.dll", 0x3950830, 0xD8, 0x18, 0xC8, 0x18, 0x180, 0x98, 0xC24 ;

int act2mainmissions1: "Disrupt_b64.dll", 0x3950830, 0x60, 0xD8, 0xC8, 0x40, 0x8, 0x2C4;
int act2mainmissions2: "Disrupt_b64.dll", 0x3950830, 0x58, 0xC8, 0x20, 0x8, 0x108, 0x48, 0x2C4;
int act2mainmissions3: "Disrupt_b64.dll", 0x3950830, 0x58, 0xC8, 0x58, 0x38, 0x98, 0x2C4;
int act2mainmissions4: "Disrupt_b64.dll", 0x3950830, 0x10, 0x48, 0x38, 0x98, 0x2C4;
int act2mainmissions5: "Disrupt_b64.dll", 0x3950830, 0x18, 0x8, 0xE0, 0x8, 0x100, 0x8, 0x2C4;
int act2mainmissions6: "Disrupt_b64.dll", 0x3950830, 0x60, 0x8, 0xD0, 0x38, 0x48, 0x2C4;

int act3mainmissions: "Disrupt_b64.dll", 0x3950830, 0x18, 0x10, 0x50, 0x30, 0x68, 0x654;

int act4mainmissions: "Disrupt_b64.dll", 0x3950830,  0x58, 0x78, 0x98, 0x954;

}


split{  
	if(current.act1mainmissions1 == old.act1mainmissions1+1)
		return true;

	if(current.act1mainmissions2 == old.act1mainmissions2+1)
		return true; 

	if(current.act2mainmissions1 == old.act2mainmissions1+1)
		return true;

	if(current.act2mainmissions2 == old.act2mainmissions2+1)
		return true;

	if(current.act2mainmissions3 == old.act2mainmissions3+1)
		return true;

	if(current.act2mainmissions4 == old.act2mainmissions4+1)
		return true;

	if(current.act2mainmissions5 == old.act2mainmissions5+1)
		return true;

	if(current.act2mainmissions6 == old.act2mainmissions6+1)
		return true;

	if(current.act3mainmissions == old.act3mainmissions+1)
		return true;

	if(current.act4mainmissions == old.act4mainmissions+1)
		return true;
	}
