module Uninit

import Prelude;
import Abstract;
import Load;

import UseDef;
import ControlFlow;

import Relation;
import analysis::graphs::Graph;

public set[CFNode] defNodes(PicoId Id, set[Occurrence] Defs) =
   {statement(occ.stat@location, occ.stat) | Occurrence occ <- Defs, occ.name == Id};

public set[Occurrence] uninitProgram(PROGRAM P) {
   D = defs(P); // <1>
   CFG = cflowProgram(P); // <2>
   return { occ | occ <- uses(P), // <3>
                  any(CFNode N <- reachX(CFG.graph, CFG.entry, defNodes(occ.name, D)),
                      N has location && occ.location <= N.location) 
          }; // <4>
}

public set[Occurrence] uninitProgram(str txt) = uninitProgram(load(txt)); // <5>