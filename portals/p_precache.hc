void () Precache_Magic_Snd =
{
   precache_sound2 ( "golem/awaken.wav");
   precache_sound2 ( "ambience/birds.wav");
   precache_sound2 ( "ambience/newhum1.wav");
   precache_sound2 ( "zap4.wav");
   precache_sound2 ( "rw15ele5.wav");
   precache_sound2 ( "rw14nova.wav");
   precache_sound2 ( "effm03a.wav");
   precache_sound2 ( "antichkn.wav");
   precache_sound2 ( "rw11thu2.wav");
   precache_sound2 ( "lghturn.wav");
   precache_sound2 ( "dsgarstp.wav");
   precache_sound2 ( "empower.wav");
   precache_sound2 ( "slime1.wav");
   precache_sound2 ( "slime2.wav");
   precache_sound2 ( "slime3.wav");
   precache_sound2 ( "slime4.wav");
   precache_sound2 ( "slime5.wav");
   precache_sound2 ( "slime6.wav");
   precache_sound2 ( "fizzloop.wav");
   precache_sound2 ( "rw11lici.wav");
   precache_sound2 ( "rw11thuf.wav");
   precache_sound2 ( "exp3.wav");
   precache_sound2 ( "eidolon/stomp.wav");
   precache_sound2 ( "eidolon/flambrth.wav");
   precache_sound2 ( "catfire.wav");
   precache_sound2 ( "chit1.wav");
   precache_sound2 ( "chit2.wav");
   precache_sound2 ( "full.wav");
   precache_sound2 ( "lbht.wav"); //UFO
   precache_sound2 ( "bite4.wav");
   precache_sound2 ( "ebbs.wav");
   precache_sound2 ( "ebcs.wav");
   precache_sound2 ( "mortfal.wav");
   precache_sound2 ( "up.wav");
   precache_sound2 ( "thnd1.wav");
   precache_sound2 ( "thnd2.wav");
   precache_sound2 ( "thnd3.wav");
   precache_sound2 ( "thnd4.wav");
   precache_sound2 ( "hydra/tent.wav");
   precache_sound2 ( "down.wav");
   precache_sound2 ( "exp2.wav");
   precache_sound2 ( "bombinriver.wav");
 //  precache_sound2 ( "bushme.wav");
   precache_sound2 ( "burnme.wav");
   precache_sound2 ("skullwiz/push.wav");
   precache_sound2 ( "crushme.wav");
   precache_sound2 ( "dsamaln6.wav");
   precache_sound2 ( "stme.wav");
   precache_sound2 ( "stml.wav");
   precache_sound2 ( "supnova.wav");
   precache_sound2 ( "misc/tink.wav");
   precache_sound2 ( "aerostart.wav");
   precache_sound2 ( "aeroturn.wav");
   precache_sound2 ( "aeroball.wav");
   precache_sound2 ( "bh.wav");
   precache_sound2 ( "darkburst.wav");
   precache_sound2 ( "darkblast.wav");
   precache_sound2 ( "darkness.wav");
   precache_sound2 ( "darkness2.wav");
   precache_sound2 ( "darkness3.wav");
   precache_sound2 ( "tsunami.wav");
   precache_sound2 ( "trail1.wav");
   precache_sound2 ( "trail.wav");
   precache_sound2 ( "chaos.wav");
   precache_sound2 ( "beamhit4.wav");
   precache_sound2 ( "baer/gntact1.wav");
   precache_sound2 ( "golem/stomp.wav");
   precache_sound2 ( "raven/kiltorch.wav");
   precache_sound2 ( "raven/littorch.wav");
   precache_sound2 ( "raven/fire1.wav");
   precache_sound2 ( "ambience/water.wav");
   precache_sound2 ( "rj/steve.wav");
   precache_sound2 ( "weapons/ric1.wav");
   precache_sound2 ( "weapons/ric2.wav");
   precache_sound2 ( "weapons/ric3.wav");
   precache_sound2 ( "weapons/tink1.wav");
   precache_sound2 ( "weapons/r_exp3.wav");
   precache_sound2 ( "misc/squeak.wav");
   precache_sound2 ( "ambience/moan1.wav");
   precache_sound2 ( "ambience/moan2.wav");
   precache_sound2 ( "ambience/moan3.wav");
   precache_sound2 ( "weapons/vorppwr.wav");
   precache_sound2 ( "crusader/tornado.wav");
  
   precache_sound3 ( "player/money.wav");
};

void () Precache_Magic_Mdl =
{
   precache_model ( "models/a_spellmod.mdl");
   precache_model ( "models/i_spellmod.mdl");
   precache_model ( "models/star2.mdl");
   precache_model ( "models/boss/star.mdl");
   set_extra_flags ("models/boss/star.mdl", (XF_MISSILE_GLOW | XF_COLOR_LIGHT));
   set_fx_color ("models/boss/star.mdl", 1.0, 1.0, 1.0, 0.75);
   precache_model ( "models/boss/circle.mdl");
   precache_model ( "models/expring.mdl");
   precache_model ( "models/skull.mdl");
   precache_model ( "models/bushbash.mdl");
   precache_model ( "maps/portal.bsp");
   precache_model ( "models/person.mdl");
   precache_model ( "gfx/puff.spr");
   precache_model ( "models/psbg.spr");
   set_extra_flags ("models/psbg.spr", XF_COLOR_LIGHT);
   set_fx_color ("models/psbg.spr", 0.37, 0.62, 0.25, 0.89);
   precache_model ( "models/ball.mdl");
   precache_model ( "models/star.mdl");
   precache_model ( "models/mgaia.mdl");
   precache_model ( "models/twister.mdl");
   precache_model ( "models/boss/shaft.mdl");
   precache_model ( "models/cloud.mdl");
   precache_model ( "models/chair.mdl");
   precache_model ( "models/stool.mdl");
   precache_model ( "models/bench.mdl");
   precache_model ( "models/cart.mdl");
   precache_model ( "models/tree2.mdl");
   precache_model ( "models/bush1.mdl");
   precache_model ( "models/nukeball.mdl");
   precache_model ( "models/m6th.mdl");
   precache_model ( "models/arazor.mdl");
   precache_model ( "models/suck.mdl");
   precache_model ( "models/bhdestruct.mdl");
   precache_model ( "models/dmatter.mdl");
   precache_model ( "models/lmatter.mdl");
   precache_model ( "models/glowball2.mdl");
   precache_model ( "models/aero.mdl");
   precache_model ( "models/finger.mdl");
   precache_model ( "models/menubar.mdl");
   precache_model ( "models/spellcharge.mdl");
   precache_model ( "models/sflesh1.mdl");
   precache_model ( "models/sflesh2.mdl");
   precache_model ( "models/sflesh3.mdl");
   precache_model ( "models/dwarf.mdl");
   precache_model ( "models/shop.mdl");
   precache_model ( "models/shop1.mdl");  
   precache_model ( "models/shop2.mdl");  
   precache_model ( "models/glowball.mdl");
   precache_model ( "models/mcage.mdl");
   precache_model ( "models/mslide.mdl");
   precache_model ( "models/spire.mdl");
   precache_model ( "models/mspire.mdl");
   precache_model ( "models/bloodspot.mdl");
   precache_model ( "models/drumstick.mdl");
   precache_model ( "models/bread.mdl");
   precache_model ( "models/flame1.mdl");
   precache_model ( "models/lslide.mdl");
   precache_model ( "models/mghail.mdl");
   precache_model ( "models/ghail.mdl");
   precache_model ( "models/mpk.mdl");
   precache_model ( "models/mtelep.mdl");
   precache_model ( "models/iceboom.mdl");
   precache_model ( "models/mawind.mdl");
   precache_model ( "models/mspike.mdl");
   precache_model ( "models/plantgen.mdl");
   precache_model ( "models/splashy.mdl");
   precache_model ( "models/spell.mdl");
   precache_model ( "models/cblast.mdl");
   precache_model ( "models/fragm2.mdl");
   precache_model ( "models/saucer3.mdl");
   precache_model ( "models/acolor.mdl");
   precache_model ( "models/crash.mdl");
   precache_model ( "models/fragm1.mdl");
   precache_model ( "models/mtail.mdl");
   precache_model ( "models/tail.mdl");
   precache_model ( "models/mred5.mdl");
   precache_model ( "models/zap.mdl");
   precache_model ( "models/bluem.mdl");
   precache_model ( "models/red5.mdl");
   precache_model ( "models/blaze.mdl");
   precache_model ( "models/mguard.mdl");
   precache_model ( "models/mboot.mdl");
   precache_model ( "models/iceshot1.mdl");
   precache_model ( "models/mflame.mdl");
   precache_model ( "models/cool.mdl");
   precache_model ( "models/mmagnet.mdl");
   precache_model ( "models/mring.mdl");
   precache_model ( "models/menuh.mdl");
   precache_model ( "models/fball1.mdl");
   set_extra_flags ("models/fball1.mdl", (XF_MISSILE_GLOW | XF_COLOR_LIGHT));
   set_fx_color ("models/fball1.mdl", 1.0, 0.6, 0.2, 0.5);
   precache_model ( "models/sun.mdl");
   precache_model ( "models/splat.mdl");
   set_extra_flags ("models/splat.mdl", XF_COLOR_LIGHT);
   set_fx_color ("models/splat.mdl", 1.0, 0.125, 0.125, 0.5);
   precache_model ( "models/flamec.mdl");
   precache_model ( "models/rat.mdl");
   precache_model ( "models/akarrow.mdl");
   precache_model ( "models/gold.mdl");
   precache_model ( "models/quiver.mdl");
   precache_model ( "models/dthball.mdl");
   precache_model ( "models/teleport.mdl");
   precache_model ( "models/blast.mdl");
   set_extra_flags ("models/blast.mdl", XF_COLOR_LIGHT);
   set_fx_color ("models/blast.mdl", 1.0, 0.3625, 0.01, 0.5);
   precache_model ( "models/vorpshk2.mdl");
   precache_model ( "models/i_ymana.mdl");
   set_extra_flags ("models/i_ymana.mdl", XF_GLOW);
   set_fx_color ("models/i_ymana.mdl", 0.5, 0.5, 0.125, 0.5);
};

void () Precache_Magic =
{
	Precache_Magic_Snd();
	Precache_Magic_Mdl();
};


/*
void () Precache_Magic =
{
   precache_model ( "models/bloodspot.mdl");
   precache_model ( "models/flamec.mdl");
   precache_model ( "models/flame1.mdl");
   precache_model ( "models/aero.mdl");
   precache_model ( "models/finger.mdl");
   precache_model ( "models/menubar.mdl");
   precache_model ( "models/spellcharge.mdl");
   precache_model ( "models/i_spellmod.mdl");
   precache_model ( "models/spell.mdl");
   precache_model ( "models/dwarf.mdl");
   precache_model ( "models/splat.mdl");
   precache_model ( "models/iceboom.mdl");
   precache_model ( "models/bushbash.mdl");
   precache_model ( "models/star2.mdl");
   precache_model ( "models/boss/star.mdl");
   precache_model ( "models/ghail.mdl");
   precache_model ( "models/glowball2.mdl");
   precache_model ( "models/dmatter.mdl");
   precache_model ( "models/lmatter.mdl");
   precache_model ( "models/expring.mdl");
   precache_model ( "models/nukeball.mdl");
   precache_model ( "models/spire.mdl");
};
*/