 // tag::module[]
 module demo::lang::Pico::Load

import Prelude;
import Syntax;
import Abstract;

public PROGRAM  load(str txt) = implode(#PROGRAM, parse(#Program, txt));
// end::module[]
