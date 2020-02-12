//NOT FINISHED AT ALL!
//TODO: buried reivers have wrong size; missile fx not working; improve blood fx

$frame 000pose

$frame 001rise 002rise 003rise 004rise 005rise 006rise 007rise 008rise 009rise 010rise 011rise 012rise 013rise 014rise 015rise 016rise 017rise 018rise 019rise 020rise 021rise 022rise 023rise 024rise

$frame 025idle 026idle 027idle 028idle 029idle 030idle 031idle 032idle 033idle 034idle 035idle 036idle 037idle 038idle

$frame 039look 040look 041look 042look 043look 044look 045look 046look 047look 048look 049look 050look 051look 052look 053look

$frame 054fire 055fire 056fire 057fire 058fire 059fire 060fire 061fire 062fire 063fire 064fire 065fire 066fire 067fire 068fire 069fire 070fire

$frame 071meleel 072meleel 073meleel 074meleel 075meleel 076meleel 077meleel 078meleel 079meleel 080meleel 081meleel 082meleel 083meleel 084meleel 085meleel 086meleel 087meleel 088meleel

$frame 089meleer 090meleer 091meleer 092meleer 093meleer 094meleer 095meleer 096meleer 097meleer 098meleer 099meleer 100meleer 101meleer 102meleer 103meleer 

$frame 104painguard 105painguard 106painguard 107painguard 108painguard 109painguard 110painguard 111painguard 112painguard 113painguard 114painguard 115painguard 116painguard 117painguard 118painguard 119painguard

$frame 120leech 121leech 122leech 123leech 124leech 125leech 126leech

$frame 127stun 128stun 129stun 130stun 131stun 132stun 133stun 134stun 135stun 136stun 137stun

$frame 138death 139death 140death 141death 142death 143death 144death

float REIV_BURIED = 2;
float REIV_DORMANT = 16;
float SF_FLYABOVE = 262144;

float REIV_HEIGHT = 400;
float REIV_RANGE = 60;
float REIV_SPEED = 6;
vector REIV_MINS = '-18 -18 0';
vector REIV_MAXS = '18 18 30';

void() reiv_buried;
void() reiv_fx;
void() reiv_melee;
void() reiv_meleedrain;
void() reiv_mis;
void(entity attacker, float damg) reiv_pain;
void() reiv_run;
void() reiv_stand;

void() precache_reiver
{
	precache_model("models/reiver.mdl");
	precache_model("models/lavaball.mdl");
	precache_model("models/fballdrop.spr");
	
	precache_sound("assassin/chntear.wav");
	precache_sound("imp/fireball.wav");
	precache_sound("misc/rubble.wav");
	precache_sound("reiv/blood.wav");
	precache_sound("reiv/die.wav");
	precache_sound("reiv/idle.wav");
	precache_sound("reiv/pain.wav");
	precache_sound("reiv/see.wav");
	precache_sound("weapons/drain.wav");
}

void reiv_check ()
{
	local entity amstuck, stuckent;
	amstuck = findradius(self.origin, 60);
	
	while (amstuck)
	{
		if (amstuck.solid==SOLID_BBOX || amstuck.solid==SOLID_SLIDEBOX)
			stuckent = amstuck;
		amstuck = amstuck.chain;
	}
	if (!stuckent)
		self.solid = SOLID_SLIDEBOX;
	else {
		self.solid = SOLID_PHASE;
		Knockback (stuckent, self, self, 10, 0.2);
	}
}

void reiv_rise () [++ $001rise .. $024rise]
{
	reiv_check();
	if (cycle_wrapped)
	{
		self.attack_finished = time+2;
		self.movetype = MOVETYPE_STEP;
		self.th_pain = reiv_pain;
		setsize (self, REIV_MINS, REIV_MAXS);
		self.solid = SOLID_SLIDEBOX;
		self.takedamage = DAMAGE_YES;
		self.th_run = reiv_run;
		self.think = reiv_run;
		thinktime self : 0;
	}
	
	else if (self.frame == $001rise)
		setmodel (self, "models/reiver.mdl");
	else if (self.frame == $002rise)
		sound (self, CHAN_BODY, "misc/rubble.wav", 1, 0.3);
	
	if (self.frame < $012rise) {
		string mdl;
		vector org;
		float r = random();
		if (r<0.75)
			mdl = "models/schunk1.mdl";
		else if (r<0.5)
			mdl = "models/schunk2.mdl";
		else
			mdl = "models/schunk3.mdl";
		org = self.origin;
		org_y += random(self.mins_y,self.maxs_y)*0.75;
		ThrowSingleChunk (mdl, org, random(3), 1,random(0.25));
		particle(org, randomv('-6 -6 2', '6 6 6'), rint(random(98,103)), 5);	//rint(random(85,88)
	}
	else
		reiv_fx();
}

void reiv_buried ()
{
	if (!self.spawnflags & REIV_DORMANT)
		ai_stand();
	else if (self.goalentity)	//activated by targetting
	{
		eprint (self.goalentity);
		self.think=reiv_rise;
	}
	thinktime self : HX_FRAME_TIME;
}

void reiv_chargedrain () [++ $025idle .. $038idle]
{
	++self.weaponframe_cnt;
	if (self.weaponframe_cnt < 8)
		ai_face();
	
	if (!walkmove(self.angles_y, REIV_SPEED+self.weaponframe_cnt, FALSE))
	{
		self.think = reiv_meleedrain;
		thinktime self : 0;
	}
	else if (time > self.counter)
	{
		self.think = reiv_run;
		thinktime self : 0;
	}
}

void reiv_die () [++ $138death .. $144death]
{
	if (cycle_wrapped)
	{	//create bone gibs as well as blood gibs
		local entity bone;
		bone = spawn();
		bone.solid = SOLID_NOT;
		bone.thingtype = THINGTYPE_BONE;
		setmodel (bone, "models/null.spr");
		setorigin (bone, self.origin+'0 0 8');
		setsize (bone, self.mins*0.25, self.maxs*0.25);
		bone.think = chunk_death;
		thinktime bone : 0;
		
		setsize(self,self.mins*0.8,self.maxs*0.8);	//decrease size so chunk_death outputs more reasonably-sized gibs
		chunk_death();
	}
	else if (self.frame == $138death)
		sound (self, CHAN_VOICE, "reiv/die.wav", 1, ATTN_NORM);
	
	thinktime self : HX_FRAME_TIME*2;
}

void reiv_fxsplat ()
{
	sound (self, CHAN_BODY, "reiv/blood.wav", 0.75, ATTN_NORM);
	SpawnPuff(self.origin,normalize(self.velocity)*-20,10,self);
	remove(self);
}

void reiv_fx ()
{
	if (random()<0.1)
		particle4(self.origin, 8, 256 + 8 * 16 + random(9), PARTICLETYPE_FASTGRAV, 0.5);
	if (random()<0.99)
		return;
	
	//based on ThrowBlood
	entity blood;
	blood=spawn();
	blood.solid=SOLID_PHASE;
	blood.movetype=MOVETYPE_TOSS;
	blood.touch=reiv_fxsplat;
	blood.velocity=randomv('0 0 -60', '0 0 -20');
	blood.avelocity=randomv('-200 -200 -200','200 200 200');
	blood.thingtype=THINGTYPE_FLESH;
	setmodel(blood,"models/bldspot4.spr");
	if (random()<0.5)
		setmodel(blood,"models/bldspot3.spr");
	setsize(blood,'0 0 0','0 0 0');
	setorigin(blood,self.origin-'0 0 5');
}

void reiv_hit (float dir, float drain)
{
vector org1,org2;
float dist,damg;
	
	if (drain && self.aflag > time)
		return;
	
	if (!self.enemy)
		return;
	
	if (dir==0)
		dir = random(-1,1);
	damg=random(8,14);
	
	makevectors(self.angles);
	org1=self.origin+v_forward*15+(self.proj_ofs*0.5);
	org2=(self.enemy.absmin+self.enemy.absmax)*0.5;
	dist=vlen(org2-org1);
	
	if (dist > REIV_RANGE)
		return;
	
	traceline(org1,org2,FALSE,self);
	if (trace_fraction==0)
		traceline(org1,org2+v_up*30,FALSE,self);
	if (trace_fraction==0)
		traceline(org1,org2-v_up*30,FALSE,self);
	if (trace_fraction==0)
		traceline(org1,org2+v_right*15,FALSE,self);
	if (trace_fraction==0)
		traceline(org1,org2-v_right*15,FALSE,self);
	
	if (trace_fraction == 0 || !trace_ent.takedamage)
		return;
	
	if (!trace_ent.flags & FL_MONSTER && !trace_ent.flags & FL_CLIENT)
		drain = FALSE;
	
	T_Damage(trace_ent,self,self,damg);
	if (drain)
	{
		sound (self, CHAN_BODY, "weapons/drain.wav", 1, ATTN_NORM);
		self.health += damg;
		if (self.health > self.height)
			self.health = self.height;	//dont give more than spawn health
	}
	sound(self,CHAN_WEAPON,"assassin/chntear.wav",1,ATTN_NORM);
	SpawnPuff(trace_endpos,(v_right*100)*dir,10,trace_ent);
	if(trace_ent.thingtype==THINGTYPE_FLESH)
		MeatChunks (trace_endpos,(v_right*random(-200,200))*dir+'0 0 200', 3,trace_ent);
	
	self.aflag = time+0.5;
}

void reiv_charge ()
{
	++self.weaponframe_cnt;
	ai_charge(REIV_SPEED+self.weaponframe_cnt);
}

void reiv_meleeL () [++ $071meleel .. $088meleel]
{
	reiv_fx();
	
	if (self.frame <= $077meleel)
		reiv_charge();
	
	if (self.frame == $077meleel)
		reiv_hit(-1, FALSE);
	
	else if (cycle_wrapped)
	{
		self.weaponframe_cnt = 0;
		self.lefty = FALSE;
		self.think = reiv_run;
		thinktime self : 0;
	}
}

void reiv_meleeR () [++ $089meleer .. $103meleer]
{
	reiv_fx();
	
	if (self.frame <= $095meleer)
		reiv_charge();	//ai_face();
	
	if (self.frame == $095meleer)
		reiv_hit(1, FALSE);
	
	else if (cycle_wrapped)
	{
		self.weaponframe_cnt = 0;
		self.lefty = TRUE;
		self.think = reiv_run;
		thinktime self : 0;
	}
}

void reiv_meleedrain () [++ $120leech .. $126leech]
{
	reiv_fx();
	reiv_charge();
	
	if (self.frame >= $122leech && self.frame <= $124leech)
		reiv_hit(0, TRUE);
	
	if (cycle_wrapped)
	{
		self.weaponframe_cnt = 0;
		self.think = reiv_run;
		thinktime self : 0;
	}
}

void reiv_melee ()
{
	ai_face();
	
	if (self.health < self.height*0.666 || random()<0.05)
		self.think = reiv_meleedrain;
	
	else if (self.lefty)
		self.think = reiv_meleeL;
	else
		self.think = reiv_meleeR;
	
	thinktime self : 0;
}

void reiv_misfx () [++ 1 .. 7]
{
	//AdvanceFrame (1,7);
	if (self.frame==7)
		remove(self);
}

void reiv_misthink ()
{
	particle4(self.origin-'0 0 10', 20, rint(random(134,138)), PARTICLETYPE_SLOWGRAV, 1);
	if (random()<0.5) {	//dprint ("thinkan\n");
		entity fx = spawn();
		setmodel (fx, "models/fballdrop.spr");
		setorigin (fx, self.origin-'0 0 15');
		setsize (fx, '0 0 0', '0 0 0');
		fx.abslight = 1;
		fx.velocity = '0 0 -10';
		fx.think = reiv_misfx;
		thinktime fx : 0;
		//fx.think = SUB_Remove;
		//thinktime fx : HX_FRAME_TIME*7;
	}
	thinktime self : HX_FRAME_TIME;
}

void reiv_misfire () [++ $054fire .. $070fire]
{
	reiv_fx();
	if (self.frame <= $064fire)
	{
		ai_face();
		ChangePitch();		//idea: adjust pitch to match aim?
	}
	
	if (self.frame == $064fire)
	{
		fx_light (self.origin+self.proj_ofs, EF_MUZZLEFLASH);
		sound (self, CHAN_WEAPON, "imp/fireball.wav", 1, ATTN_NORM);
		
		vector org1,org2,diff;
		entity newmis;
		makevectors(self.angles);
		org1 = self.origin+self.proj_ofs;
		org2 = self.enemy.origin+self.enemy.proj_ofs;
		//if only Create_Missile returned the entity spawned, then i could just use that and give it the think function i want, rather than copying it
		newmis = spawn ();
		newmis.owner = self;
		newmis.movetype = MOVETYPE_FLYMISSILE;
		newmis.solid = SOLID_BBOX;
		
		diff = normalize(org2 - org1);
		diff+=aim_adjust(self.enemy);

		newmis.velocity = diff*200;
		newmis.angles = vectoangles(newmis.velocity);
		
		newmis.scale = 0.75;
		setmodel (newmis,"models/lavaball.mdl");
		setsize (newmis, '-5 -5 -5', '5 5 5');
		setorigin (newmis, org1);
		
		newmis.touch = fireballTouch;
		newmis.think = reiv_misthink;
		thinktime newmis : HX_FRAME_TIME;
	}
	if (cycle_wrapped)
	{
		self.think = reiv_run;
		thinktime self : 0;
	}
}

void reiv_mis ()
{
	local float r = range(self.enemy);
	if (r == RANGE_MELEE)
		self.think = reiv_melee;
	else if (r <= RANGE_NEAR && self.health < self.height*0.666) {
		sound (self, CHAN_VOICE, "reiv/idle.wav", 1, ATTN_NORM);
		self.counter = time+1.25;	//stop charging at this time
		self.think = reiv_chargedrain;
	}
	else
		self.think = reiv_misfire;
	
	thinktime self : 0;
}

void reiv_painguard () [++ $104painguard .. $119painguard]
{
	reiv_fx();
	if (self.frame == $110painguard || self.frame == $111painguard)
		reiv_hit(0, FALSE);
	
	if (cycle_wrapped)
	{
		self.pain_finished = time+1.25;
		self.think = reiv_run;
		thinktime self : 0;
	}
}

void reiv_painstun () [++ $127stun .. $137stun]
{
	reiv_fx();
	if (self.frame < $130stun)
		ai_back(2);
	
	if (cycle_wrapped)
	{
		self.pain_finished = time+1.25;
		self.think = reiv_run;
		thinktime self : 0;
	}
}

void reiv_pain (entity attacker, float damg)
{
	if (self.pain_finished > time)
		return;
	
	sound (self, CHAN_VOICE, "reiv/pain.wav", 1, ATTN_NORM);
	MeatChunks (self.origin+randomv(self.mins*0.75, self.maxs*0.75),v_right*random(-200,200)+'0 0 200', 3,self);
	
	if (vlen(self.origin-self.enemy.origin) < REIV_RANGE*1.5 || random()<0.1)
		self.think = reiv_painguard;
	else
		self.think = reiv_painstun;
	
	thinktime self : 0;
}

void reiv_run () [++ $025idle .. $038idle]
{
	ai_run(REIV_SPEED);
	reiv_fx();
	self.weaponframe_cnt = 0;
	if (self.spawnflags & SF_FLYABOVE && self.enemy.origin_z < self.origin_z) {
		ai_face();
		float height;
		height = self.origin_z - self.enemy.origin_z;
		if (height>0 && height<REIV_HEIGHT) {
			movestep (0, 0, REIV_SPEED+2, FALSE);
		}
	}
}

void reiv_stand2 () [++ $039look .. $053look]
{
	ai_stand();
	reiv_fx();
	
	thinktime self : HX_FRAME_TIME*2;
	
	if (cycle_wrapped)
	{
		self.count = time+3;
		self.think = reiv_stand;
		thinktime self : 0;
	}
	else if (self.frame == $039look)
		sound (self, CHAN_VOICE, "reiv/idle.wav", 1, ATTN_IDLE);
}

void reiv_stand () [++ $025idle .. $038idle]
{	
	ai_stand();
	reiv_fx();
	
	if (cycle_wrapped && random()<0.1 && self.count < time)
		self.think = reiv_stand2;
}

void reiv_walk () [++ $025idle .. $038idle]
{
	ai_walk(REIV_SPEED*0.5);
}

/*monster_reiver (1 0.3 0) (-20 -20 0) (20 20 32) AMBUSH 
	
	Experience: 40
	Health: 120
*/
void monster_reiver ()
{
	if(deathmatch)
	{
		remove(self);
		return;
	}

	if(!self.flags2&FL_SUMMONED && !self.flags2&FL2_RESPAWN)
		precache_reiver();
	
	self.aflag = 0;	//counter for draining health
	self.count = time+2;	//counter for look anim
	self.experience_value = 40;
	self.flags (+) FL_FLY;
	if (!self.health)
		self.health = 120;
	self.height = self.health;	//save spawn health for later checks
	//self.mass = 6;
	self.monsterclass = CLASS_GRUNT;
	self.movetype = MOVETYPE_STEP;
	self.proj_ofs = '0 0 24';
	self.sightsound = "reiv/see.wav";
	self.solid = SOLID_SLIDEBOX;
	self.thingtype = THINGTYPE_FLESH;
	self.view_ofs = '0 0 32';
	self.weaponframe_cnt = 0;	//counter for charge speed
	self.yaw_speed = 12;
	
	setmodel (self, "models/reiver.mdl");
	setsize (self, REIV_MINS, REIV_MAXS);
	
	if (self.spawnflags & REIV_BURIED)
	{
		self.mdl = self.model;
		self.movetype = MOVETYPE_NOCLIP;
		self.solid = SOLID_NOT;
		self.takedamage = DAMAGE_NO;
		self.th_stand = reiv_buried;
		self.th_run = reiv_rise;
		self.th_pain = SUB_Null;
		setmodel (self, "models/null.spr");
		if (self.spawnflags&REIV_DORMANT && self.targetname == "")
			dprint ("Error: dormant Reiver has no targetname!\n");
	}
	else
	{
		self.th_stand = reiv_stand;
		self.th_run = reiv_run;
		self.th_pain = reiv_pain;
	}
	
	self.th_walk = reiv_walk;
	self.th_melee = reiv_melee;
	self.th_missile = reiv_mis;
	self.th_die = reiv_die;
	
	flymonster_start();
}
