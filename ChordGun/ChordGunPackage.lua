--[[
Description: Chord Gun
Author: pandabot
License: MIT
Version: 1.0
Screenshot: https://github.com/benjohnson2001/ChordGun/raw/master/ChordGun/src/images/chordGunInterface.png
Donate: https://paypal.me/benjohnson2001
Link: https://forum.cockos.com/member.php?u=127396
Metapackage: true
Provides:
    [main=main,midi_editor] pkg/*.lua
About:

    ### Chord Gun
    
    #### What is it?
    Reaper tool that fires scale chords and notes into a composition, either by sequencing through the MIDI Editor or recording directly into Media Items.
    <br/>

    #### How do I use it?
    There is an instructional video [here](www.youtube.com/watch?v=1CqVYcN3VAw)
		<br/>

    #### keyboard shortcuts (when GUI has focus)
    0 - stop all notes from playing<br/>
    1 - play scale chord 1<br/>
    2 - play scale chord 2<br/>
    3 - play scale chord 3<br/>
    4 - play scale chord 4<br/>
    5 - play scale chord 5<br/>
    6 - play scale chord 6<br/>
    7 - play scale chord 7<br/>
    q - higher scale note 1<br/>
    w - higher scale note 2<br/>
    e - higher scale note 3<br/>
    r - higher scale note 4<br/>
    t - higher scale note 5<br/>
    y - higher scale note 6<br/>
    u - higher scale note 7<br/>
    a - scale note 1<br/>
    s - scale note 2<br/>
    d - scale note 3<br/>
    f - scale note 4<br/>
    g - scale note 5<br/>
    h - scale note 6<br/>
    j - scale note 7<br/>
    z - lower scale note 1<br/>
    x - lower scale note 2<br/>
    c - lower scale note 3<br/>
    v - lower scale note 4<br/>
    b - lower scale note 5<br/>
    n - lower scale note 6<br/>
    m - lower scale note 7<br/>
    ctrl+, - decrement scale tonic note<br/>
    ctrl+. - increment scale tonic note<br/>
    ctrl+shift+, - decrement scale type<br/>
    ctrl+shift+. - increment scale type<br/>
    option+, - halve grid size<br/>
    option+. - double grid size<br/>
    option+shift+, - decrement octave<br/>
    option+shift+. - increment octave<br/>
    command+, - decrement chord type<br/>
    command+. - increment chord type<br/>
    command+shift+, - decrement chord inversion<br/>
    command+shift+. - increment chord inversion<br/>
--]]