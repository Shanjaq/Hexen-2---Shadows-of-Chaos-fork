/*
 * $Header: /cvsroot/uhexen2/gamecode/hc/h2/vorpal.hc,v 1.3 2007-03-18 08:11:02 sezero Exp $
 */

/*
==============================================================================

Q:\art\models\weapons\vorpal\final\vorpal.hc

==============================================================================
*/

// For building the model
$cd Q:\art\models\weapons\vorpal\final
$origin 0 0 0
$base BASE skin
$skin skin
$flags 0

$frame SwdRoot      
//

// FRAME 2 - 23
$frame 2ndSwd1      2ndSwd2      2ndSwd3      2ndSwd4      2ndSwd5      
$frame 2ndSwd9      2ndSwd10     
$frame 2ndSwd11     2ndSwd13     2ndSwd14     2ndSwd15     
$frame 2ndSwd16     2ndSwd18     2ndSwd19     2ndSwd21     
$frame 2ndSwd22     2ndSwd23     2ndSwd24     2ndSwd25     2ndSwd26     
$frame 2ndSwd27     2ndSwd28
     
//
// FRAME 24 - 36
$frame 3rdSwd1      3rdSwd2            
$frame 3rdSwd9         
$frame 3rdSwd11     3rdSwd12     3rdSwd13     3rdSwd14     3rdSwd15     
$frame 3rdSwd16     3rdSwd17     
$frame 3rdSwd22     3rdSwd23     3rdSwd24     

// FRAME 113 - 131
$frame 6thSwd13     6thSwd14     6thSwd15     
$frame 6thSwd16     6thSwd17

// FRAME 132 - 140
$frame 4thSwd1     4thSwd2     4thSwd3     4thSwd4     4thSwd5   
$frame 4thSwd7	   4thSwd8     4thSwd10    4thSwd12    4thSwd14   4thSwd17 4thSwd18 4thSwd28

float VORP_BASE_DAMAGE			= 15;
float VORP_ADD_DAMAGE			= 10;
float VORP_PWR_BASE_DAMAGE		= 50;
float VORP_PWR_ADD_DAMAGE		= 30;
float VORP_RADIUS			= 150;
float VORP_FORCE			= 10;
float VORP_THROW_COST = 4;
float VORP_TOME_EXTRACOST = 2;

string VORP_TEXMOD				= "models/vorpal.mdl";

float HasSpecialAttackInt(entity ent);

void missile_gone(void)
{
	sound (self, CHAN_VOICE, "misc/null.wav", 1, ATTN_NORM);
	sound (self, CHAN_WEAPON, "misc/null.wav", 1, ATTN_NORM);
	remove(self);
}

void() QuietusTouch
{
	if(other.classname=="player")
		return;

	if(other.takedamage)
		T_Damage(other,self,self.owner,self.dmg);

	T_RadiusDamage(self,self.owner,self.dmg / 2,other);
	sound(self,CHAN_AUTO,"weapons/impact.wav",1,ATTN_NORM);
	starteffect(CE_MAGIC_MISSILE_EXPLOSION,self.origin-self.movedir*8,0.05);
	remove(self);

}

void FireQuietus (float offset, float hoff, float foff)
{
vector org;
local vector offorg;
entity quietus;

	if (self.bluemana < 12)
		return;
	quietus=spawn();
	setmodel(quietus,"models/blufire.mdl");
	//quietus.th_die=MultiExplode;
	if(self.classname=="player")
	{
		self.bluemana-=2;
		self.velocity+=normalize(v_forward)*-10;//include mass
		self.flags(-)FL_ONGROUND;
	}
	quietus.classname="quietus";
	self.punchangle_x = -3;
	//sound(self,CHAN_AUTO,"paladin/vorpswng.wav",1,ATTN_NORM);
	self.attack_finished=time + 0.7;
	self.effects(+)EF_MUZZLEFLASH;
	makevectors(self.v_angle);
	quietus.angles = self.v_angle;
	quietus.speed=700;
	quietus.o_angle=normalize(v_forward + v_right*offset + v_up*hoff);		
	quietus.velocity=quietus.o_angle*quietus.speed;
	quietus.veer=30;
	quietus.lifetime=time + 3;
	quietus.dmg=25;
	quietus.movetype=MOVETYPE_FLYMISSILE;
	offorg=self.origin;
	org=self.origin+self.proj_ofs+(v_forward*foff)*25;
	setsize(quietus,'1 1 1', '1 1 1');
//	quietus.abslight = 0.5;
	// Pa3PyX
//	quietus.drawflags(+)MLS_FIREFLICKER;//|MLS_ABSLIGHT;
	quietus.abslight = 1.0;
	quietus.drawflags (+) (MLS_FIREFLICKER | MLS_ABSLIGHT);

	quietus.avelocity='-1500 600 0';
	//quietus.avelocity='-700 400 0';
	

	quietus.owner=self.owner;

	quietus.solid=SOLID_BBOX;
	quietus.touch=QuietusTouch;

	//quietus.think=QuietusThink;
	//thinktime quietus : 0.2;

	setorigin(quietus,org);
}

void vshock2_run(void)
{
	self.effects (-) EF_NODRAW;

	if (self.skin ==0)
	{
		self.skin = 1;
		self.scale = random(.80, 1.4 );
	}
	else
	{
		self.skin = 0;
		self.scale = random(.80, 1.4 );
	}
	
	self.think = vshock2_run;
	thinktime self : HX_FRAME_TIME;

	if (self.lifetime <time)
		remove(self);
}


void vshock2_start()
{
	vector holdangle;

	makevectors(self.angles);
	holdangle = self.angles;

	holdangle_x += 90;				// Flip it 90
	holdangle_y = random(0,360);	// Any yaw

//dprintv("\n\n self angle:%s",self.angles);
//	dprintv("\n old angle:%s",holdangle);

	makevectors(holdangle);
	self.velocity=normalize(v_forward);
	self.velocity = self.velocity * 80;

	self.angles = holdangle;

//	self.lifetime = time + random(.25,.75);
	self.lifetime = time + .75;

	self.think = vshock2_run;
	thinktime self : HX_FRAME_TIME + random(.1,.25);
}

void vorp_shock2(float dir)
{
	entity newent;

	newent = spawn();

	newent.owner = self.owner;
	newent.movetype = MOVETYPE_NOCLIP;
	newent.solid = SOLID_NOT;

	newent.drawflags=MLS_ABSLIGHT;
	newent.abslight=0.5;
		
	setorigin(newent,self.origin);
	setmodel (newent, "models/vorpshk2.mdl");
	setsize (newent, '0 0 0', '0 0 0');		

	newent.effects (+) EF_NODRAW;
	newent.think = vshock2_start;
	newent.nextthink = time + random(.15,.50);
	newent.scale = 1;
	newent.count = dir;
	newent.angles = self.angles;
}


void vshock_end(void)
{
	if (self.skin ==0)
		self.skin = 1;
	else
		self.skin = 0;

	self.scale -=.25;

	if (self.scale<=0)
	{
		remove(self);
	}

	self.think = vshock_end;
	thinktime self : HX_FRAME_TIME;

}


void vshock_run(void)
{
	float damg;
	float shock_cnt;

	if (self.skin ==0)
	{
		self.skin = 1;
		self.scale = random(.80, 1.4 );
	}
	else
	{
		self.skin = 0;
		self.scale = random(.80, 1.4 );
	}

	if (self.enemy.health)
	{
		if (self.classname == "vorpalhalfshock")
		{
			damg = 2.5;
		}
		else
			damg = 5;

		T_Damage (self.enemy, self, self.owner, damg);
	}
	
	self.think = vshock_run;
	thinktime self : HX_FRAME_TIME;

	if (self.lifetime <time)
	{
		shock_cnt = random(0,4);
		shock_cnt =1;
		if (shock_cnt >0)
		   vorp_shock2(0);
		if (shock_cnt >1)
			vorp_shock2(1);
		if (shock_cnt >2)
			vorp_shock2(0);
		if (shock_cnt >3)
			vorp_shock2(1);

		vshock_end();
	}
}

void vorp_shock(entity victim)
{
	entity newent;
	vector org;

	org = self.origin - 8*normalize(self.velocity);

	self.angles_y += 180;  // Because it has bounced off whatever it hit
	makevectors(self.angles);	
	traceline (org ,org + v_forward * 16, FALSE, self);

//newent2 = spawn();
//	CreateEntityNew(newent2,ENT_SEAWEED,"models/flag.mdl",chunk_death);
//	setorigin(newent2,self.origin);

//	newent3 = spawn();
//	CreateEntityNew(newent3,ENT_SEAWEED,"models/skllstk1.mdl",chunk_death);
//	setorigin(newent3,self.origin + v_forward * 32);
	
	if (other.classname=="worldspawn")
	{
		// Flat to the surface
		self.angles = vectoangles(trace_plane_normal);
	}

	newent = spawn();

	setorigin(newent,org);
	setmodel (newent, "models/vorpshok.mdl");
	setsize (newent, '0 0 0', '0 0 0');		
	newent.owner = self.owner;
	newent.movetype = MOVETYPE_NONE;
	newent.solid = SOLID_NOT;
	newent.angles = self.angles;
	newent.enemy = victim;

	if (self.classname == "halfvorpmissile")
		newent.classname = "vorpalhalfshock";
	else
		newent.classname = "vorpalshock";

	newent.drawflags=MLS_ABSLIGHT;
	newent.abslight=0.5;
		
	newent.think = vshock_run;
	thinktime newent : HX_FRAME_TIME;

	newent.lifetime = time + .5;
	newent.scale = 1;
	
	sound (newent, CHAN_WEAPON, "misc/lighthit.wav", 1, ATTN_NORM);
}

/*
============
vorpmissile_touch - vorpmissile hit something. Death to the infidel!
============
*/
void vorpmissile_touch (void)
{
	//float	damg; 	//ws: moved to .dmg field, spawn function

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		missile_gone();
		return;
	}

	/*damg = random(15,30);
	
	if (self.classname == "halfvorpmissile")
	{
		damg = damg * .5;
	}*/

	if (other.health)
		T_Damage (other, self, self.owner, self.dmg);

	sound (self, CHAN_WEAPON, "weapons/explode.wav", 1, ATTN_NORM);

	vorp_shock(other);

	missile_gone();
}

void vorpmissile_run (void) [++ 16 .. 29]
{
	if (self.skin == 0)
		self.skin = 1;
	else if (self.skin == 1)
		self.skin = 0;

	if (self.scale<2.4)
		self.scale += .2;

	if (self.scale >2.4)
		self.scale = 2.4;
}

void vorpmissile_birth (void) [++ 0 .. 15]
{
	if (self.skin == 0)
		self.skin = 1;
	else if (self.skin == 1)
		self.skin = 0;

	self.frame+=2;

	if (self.scale<2.4)
		self.scale += .15;
	
	if (self.scale >2.4)
		self.scale = 2.4;
		
	if (self.frame >= 14)
		vorpmissile_run();
}



/*
============
launch_vorpal_missile - create and launch vorpal missile
============
*/
void launch_vorpal_missile(float tome)
{
	float strmod, wismod;
	
	strmod = self.strength;
	wismod = self.wisdom;

	entity missile;

	missile = spawn ();

	CreateEntityNew(missile,ENT_VORP_MISSILE,"models/vorpshot.mdl",SUB_Null);

	missile.owner = self;
	missile.classname = "vorpalmissile";
			
	// set missile speed	
	makevectors (self.v_angle);
	missile.velocity = normalize(v_forward);
	missile.velocity = missile.velocity * 1000;
	
	missile.dmg = random(15, 30) + wismod*0.5;	//wismod starts at ~8
	missile.frags=TRUE;
	missile.touch = vorpmissile_touch;
	missile.angles = vectoangles(missile.velocity);
	missile.angles_x += 180;
	missile.drawflags=MLS_ABSLIGHT;
	missile.abslight=0.5;

//	setorigin (missile, self.origin + v_up * 40);
	setorigin (missile, self.origin + self.proj_ofs);
	missile.scale = .5;

	if (!tome)
	{
		missile.dmg *= 0.5;
		missile.classname = "halfvorpmissile";
	}

	thinktime missile : HX_FRAME_TIME;

	missile.think = vorpmissile_birth;
	missile.lifetime = time + 2;

}

/*
============
Smite that which is directly in front of you
============
*/
//void(float damage,entity victim) spawn_touchpuff;

void vorpal_melee (float tome)
{
	vector	source;
	vector	org;
	float damg, force;
	float no_flash;
	float strmod;
	
	strmod = self.strength;
	force = VORP_FORCE;		//default knockback value used without mana

	makevectors (self.v_angle);
	source = self.origin+self.proj_ofs;
	traceline (source, source + v_forward*64, FALSE, self);  // Straight in front

	self.enemy = world;

	if (trace_fraction == 1.0)	// Anything right in front ?
	{
		traceline (source, source + v_forward*88 - (v_up * 30), FALSE, self);  // 30 down
	
		if (trace_fraction == 1.0)  
		{
			traceline (source, source + v_forward*88 + v_up * 30, FALSE, self);  // 30 up
		
			if (trace_fraction == 1.0)  
				return;
		}
	}
	
	org = trace_endpos + (v_forward * 2);

	if (trace_ent.takedamage) 	// It can be hurt
	{
		if(trace_ent.thingtype == THINGTYPE_FLESH)
		{
			self.weaponmodel = "models/vorpalblood.mdl";
			VORP_TEXMOD = "models/vorpalblood.mdl";
		}
		
		self.enemy = trace_ent;

		no_flash = 0;
		if ((self.bluemana >= 4) && (tome)) // Tome of power melee damage
		{
			damg = 80 + (random(strmod));
			force *= 3.5;
		}
		else if (self.bluemana >= 2)
		{
			damg = 40 + random(strmod*0.5);
			force *= 2.5;
		}
		else 
		{
			no_flash =1;
			damg = 20 + random(strmod*0.5);
		}
		
		if (!MetalHitSound(trace_ent.thingtype))
			sound (self, CHAN_WEAPON, "weapons/vorpht1.wav", 1, ATTN_NORM);
		
		if (trace_ent.flags & FL_MONSTER && self.bluemana>=2)  // Only monsters make it use mana
		{
			if (tome && self.bluemana >= 4)
				self.bluemana -= 4;
			else
				self.bluemana -= 2;
		}
		
		SpawnPuff (org, '0 0 0', damg, trace_ent);
		if (!no_flash)
		{
			org = trace_endpos + (v_forward * -1);
			CreateLittleWhiteFlash(org);
		}
		Knockback (trace_ent, self, self, force, 0.6);		//dont want to use damg, because knockback already scales with strength
		T_Damage (trace_ent, self, self, damg);
	}
	else	// hit wall
	{
		sound (self, CHAN_WEAPON, "weapons/vorpht2.wav", 1, ATTN_NORM);
		org = trace_endpos + (v_forward * -1);
		CreateWhiteSmoke(org+'0 0 10','0 0 2',HX_FRAME_TIME);
	}
}

/*
============
Deflect missiles
============
*/

void vorpal_downmissile (void)
{
	vector  dir;
	entity  victim;
	float chance;
	//entity hold;

	if (!self.artifact_active & ART_TOMEOFPOWER)
		return;

	victim = findradius(self.origin, 150);
	while(victim)
	{
		if ((victim.movetype == MOVETYPE_FLYMISSILE) && (victim.owner != self))
		{
			victim.owner = self;
			chance = random();
			dir = victim.origin + (v_forward * -1);
			CreateLittleWhiteFlash(dir);
			sound (self, CHAN_WEAPON, "weapons/vorpturn.wav", 1, ATTN_NORM);
			if (chance < 0.9)  // Deflect it
			{
				victim.v_angle = self.v_angle + randomv('-180 -180 -180', '180 180 180'); 

				makevectors (victim.v_angle);
				victim.velocity = v_forward * 1000;
			}
			else  // reflect missile
				victim.velocity = '0 0 0' - victim.velocity;
		}
		victim = victim.chain;
	}
}


/*
============
Fire Vorpal sword in normal mode
============
*/
void vorpal_normal_fire (float tome)
{
	entity  victim;
	float damg,damage_flg;
	float strmod, wismod;
	
	strmod = self.strength;
	wismod = self.wisdom;

	vorpal_melee (tome);
	if (tome)
		vorpal_downmissile();

	if (self.bluemana<2)   // Not enough mana to fire it
		return;

	damage_flg = 0;
	victim = findradius( self.origin, 100);
	while(victim)
	{	// Enemy would be the one that took direct melee damage so don't hurt him twice
		if ((victim.health) && (victim!=self) && (victim!=self.enemy))
		{
			traceline (self.origin + self.owner.view_ofs, victim.origin, FALSE, self);  // 30 up

			if (trace_ent == victim)
			{
				damage_flg = 1;

				sound (self, CHAN_WEAPON, "weapons/vorpblst.wav", 1, ATTN_NORM);

				CreateWhiteSmoke(victim.origin + '0 0 30','0 0 8',HX_FRAME_TIME);

				//add strmod to randomized damage
				damg = VORP_BASE_DAMAGE + random(VORP_ADD_DAMAGE + (strmod / 2));
				
				//add damage for tome
				if (tome)
					damg *= 1.5;
				
				Knockback (trace_ent, self, self, VORP_FORCE, 0.3);
				SpawnPuff (trace_endpos, '0 0 0', 10, trace_ent);
				T_Damage (victim, self, self, damg);
			}
		}

		victim = victim.chain;
	}

	if (trace_ent.flags & FL_MONSTER)  // Only monsters make it use mana
		self.bluemana -= 2;
}

/*
============
Fire Vorpal sword in Power Up mode
============
*/
void vorpal_altfire (float tome)
{
	vorpal_melee (tome);
	
	if (self.bluemana >= VORP_THROW_COST)
	{
		self.bluemana -= VORP_THROW_COST;
		
		if (tome && self.bluemana >= VORP_TOME_EXTRACOST)
		{
			launch_vorpal_missile(TRUE);
			self.bluemana -= VORP_TOME_EXTRACOST;
		}
		else
		{
			launch_vorpal_missile(FALSE); //if out of mana for tome, treat as normal throw
		}
	}
}

/*
============
Decide if vorpal sword is in Normal or Powerup mode
============
*/
void vorpal_fire (float rightclick)
{
	float tome;

	tome = self.artifact_active & ART_TOMEOFPOWER;

	if (rightclick && self.level>=3)
		vorpal_altfire(tome);
	else
		vorpal_normal_fire(tome);
}

/*
============
vorpal_ready - vorpal sword is in ready position
============
*/
void vorpal_ready (void) 
{
	//self.weaponframe = $SwdRoot;
	if(self.artifact_active&ART_TOMEOFPOWER)
	{
		self.weaponmodel = "models/vorpaltome.mdl";
		self.wfs = advanceweaponframe(57,60);
	}
	else
	{
		//if(self.weaponmodel != "models/vorpalblood.mdl")
		self.weaponmodel = VORP_TEXMOD;
		self.weaponframe = $SwdRoot;
	}
	self.th_weapon=vorpal_ready;
}

/*
============
vorpal_twitch - vorpal sword twitches 
============
*/
void vorpal_twitch (void)
{
	self.wfs = advanceweaponframe($2ndSwd1,$2ndSwd28);
	self.th_weapon = vorpal_twitch;

	if (self.weaponframe == $2ndSwd11)	// Frame 48
		sound (self, CHAN_WEAPON, "weapons/vorpswng.wav", 1, ATTN_NORM);
	else if (self.weaponframe == $2ndSwd18)	// Frame 55
		sound (self, CHAN_WEAPON, "weapons/vorpswng.wav", 1, ATTN_NORM);

	if (self.wfs == WF_LAST_FRAME)
		vorpal_ready();
}

// Rotate model around player
void moveswipe(void) [++0 .. 6]
{ 
	vector org;

	makevectors (self.owner.v_angle);
	org = self.owner.origin + self.owner.view_ofs - '0 0 25';
	setorigin (self, org);
	self.angles = self.owner.v_angle;
	self.angles_y += 180;

	self.think = moveswipe;
	thinktime self : HX_FRAME_TIME;

	if (self.frame>5)		
		self.think = SUB_Remove;
}


void SpawnSwipe(void)
{
	entity swipe;
	vector org;

	swipe = spawn ();

	CreateEntityNew(swipe,ENT_SWIPE,"models/vorpswip.mdl",SUB_Null);

	makevectors (self.v_angle);
	swipe.angles = self.v_angle;
	swipe.angles_y += 180;

	org = self.origin + self.view_ofs - '0 0 25';
	setorigin (swipe, org);
	
	swipe.counter =0;
	swipe.owner = self;

	swipe.velocity = '0 0 0';
	swipe.touch = SUB_Null;
	swipe.drawflags(+)DRF_TRANSLUCENT;

	swipe.think = moveswipe;
	thinktime swipe : HX_FRAME_TIME;

}

void vorpal_sound ()
{
	if (self.artifact_active&ART_TOMEOFPOWER && self.altfiring && self.bluemana >= 12)
		sound (self, CHAN_WEAPON, "weapons/quiet.wav", 1, ATTN_NORM);
	else if (self.altfiring && self.bluemana >= VORP_THROW_COST && self.level>=3)
		sound (self, CHAN_WEAPON, "weapons/vorppwr.wav", 1, ATTN_NORM);
	else if (self.artifact_active&ART_TOMEOFPOWER)
		sound (self, CHAN_AUTO, "weapons/vorppwrs.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_WEAPON, "weapons/vorpswng.wav", 1, ATTN_NORM);
}

void vorpal_a ()
{
	float rightclick, tome;
	
	rightclick = self.button1;
	tome = self.artifact_active&ART_TOMEOFPOWER;
	if (self.altfiring > 0)
		rightclick = TRUE;
	
	self.wfs = advanceweaponframe($3rdSwd1,$3rdSwd24);
	self.th_weapon = vorpal_a;
	
	if (self.weaponframe == $3rdSwd2)	// Frame 80
		vorpal_sound();
	
	else if (self.weaponframe == $3rdSwd9)	// Frame 84
	{
		if(tome && rightclick && self.bluemana >= 12)
		{
			//if (self.level >= 5)
				FireQuietus(-0.07,-0.001, -0.2);
			//if (self.level >= 2)
				FireQuietus(-0.04,0, 0.1);
				
			FireQuietus(0, 0, 0.8);
			
			//if (self.level >= 2)
				FireQuietus(.04,0, 1.4);
			//if (self.level >= 5)
				FireQuietus(0.07,0.001, 1.8);
		}
		else 
			vorpal_fire (rightclick);
		
		self.punchangle_y= -2;
		self.altfiring = 0;	//track right click
	}

	if ((self.weaponframe == $3rdSwd9) && (self.bluemana>=2))
		SpawnSwipe();

	if (self.wfs == WF_LAST_FRAME)
		self.th_weapon=vorpal_ready;
}

void vorpal_b ()
{
	float rightclick, tome;
	
	rightclick = self.button1;
	tome = self.artifact_active&ART_TOMEOFPOWER;
	if (self.altfiring > 0)
		rightclick = TRUE;
	
	self.wfs = advanceweaponframe($2ndSwd14,$2ndSwd28);
	
	self.th_weapon = vorpal_b;
	
	if (self.weaponframe == $2ndSwd14)	// Frame 80
		vorpal_sound();
	
	else if (self.weaponframe == $2ndSwd22)	// Frame 84
	{
		if(tome && rightclick && self.bluemana >= 12)
		{
			//if (self.level >= 5)
				FireQuietus(-0.07,0.001, 1.3);
			//if (self.level >= 2)
				FireQuietus(-0.04,0, 1);
				
			FireQuietus(0, 0, 0.7);
			
			//if (self.level >= 2)
				FireQuietus(.04,0, 0.3);
			//if (self.level >= 5)
				FireQuietus(0.07,-0.001, 0);
		}
		else 
			vorpal_fire (rightclick);
		
		self.punchangle_y= 3;
		//self.weaponframe = 1;
		self.altfiring = 0;	//track right click
	}

	//if ((self.weaponframe == $2ndSwd21) && (self.bluemana>=2))
		//SpawnSwipe();

	if (self.wfs == WF_LAST_FRAME)
		self.th_weapon=vorpal_ready;
}

void vorpal_c ()
{
	float rightclick, tome;
	
	rightclick = self.button1;
	tome = self.artifact_active&ART_TOMEOFPOWER;
	if (self.altfiring > 0)
		rightclick = TRUE;
	
	self.wfs = advanceweaponframe($4thSwd1,$4thSwd28);
	
	self.th_weapon = vorpal_c;
	
	if (self.weaponframe == $4thSwd4)	// Frame 80
		vorpal_sound();
	
	else if (self.weaponframe == $4thSwd12)	// Frame 84
	{
		if(tome && rightclick && self.bluemana >= 12)
		{
			//if (self.level >= 5)
				FireQuietus(-0.05,-.07, 0.2);
			//if (self.level >= 2)
				FireQuietus(-0.03,-.04, 0.4);
				
			FireQuietus(0, 0, 0.8);
			
			//if (self.level >= 2)
				FireQuietus(0.03,.04, 1.2);
			//if (self.level >= 5)
				FireQuietus(.05,.07, 1.4);
		}
		else 
			vorpal_fire (rightclick);
		
		self.punchangle_x= -3;
		//self.weaponframe = 1;
		self.altfiring = 0;	//track right click
	}

	//if ((self.weaponframe == $2ndSwd21) && (self.bluemana>=2))
		//SpawnSwipe();

	if (self.wfs == WF_LAST_FRAME)
		self.th_weapon=vorpal_ready;
}


/*
============
vorpal_select - vorpal sword was just chosen
============
*/
void vorpal_select (void)
{
	self.wfs = advanceweaponframe($2ndSwd5,$2ndSwd1);
	
	self.weaponmodel = VORP_TEXMOD;
	self.th_weapon=vorpal_select;
	self.last_attack=time;

	if (self.wfs == WF_LAST_FRAME)
	{
		self.attack_finished = time - 1;
		vorpal_twitch();
	}
}

/*
============
vorpal_deselect - vorpal sword was just un-chosen
============
*/
void vorpal_deselect (void)
{
	self.wfs = advanceweaponframe($6thSwd13,$6thSwd17);
	self.th_weapon=vorpal_deselect;
	self.oldweapon = IT_WEAPON2;

	if (self.wfs == WF_LAST_FRAME)
		W_SetCurrentAmmo();

}

void pal_vorpal_fire()
{	
	float rightclick;
	rightclick = self.button1;
	if (rightclick)
		self.altfiring = 1;	//track right click
	
	if (self.attack_cnt < 1 || self.attack_cnt == 3)
	{
		vorpal_b ();
	}
	else if (self.attack_cnt == 1 || self.attack_cnt == 4) 
	{
		vorpal_a ();
	}
	else
	{
		vorpal_c ();
	}
	
	self.attack_cnt += 1;
	if (self.attack_cnt == 6)
		self.attack_cnt = -2;
	//if (self.attack_cnt > 2)
		//self.attack_finished = time + 0.5;
	//else
		self.attack_finished = time + 0.6;
}

