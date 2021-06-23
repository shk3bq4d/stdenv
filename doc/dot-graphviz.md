alternative plantuml

layout:
 circo dot fdp neato nop nop1 nop2 osage patchwork sfdp twopi

 ```bash
http://www.webgraphviz.com/
https://graphviz.gitlab.io/_pages/doc/info/attrs.html
https://www.tonyballantyne.com/graphs.html
```

```ini
digraph graphname {
	rankdir=LR;
	 a -> b -> c;
	 b -> d;
     a [label="Foo"];
     // Here, the node shape is changed.
     b [shape=box];
     // These edges both have different line properties
     a -- b -- c [color=blue];
     b -- d [style=dotted];
     // [style=invis] hides a node.
   }
}
digraph graphname {
	rankdir=LR;
	compound=true; // needed to link to make think we're linking to cluster subgraph
	subgraph cluster1 { # must start with "cluster" prefix to be visible
		nginx1;
		gl1;
	}
	subgraph cluster2 {
		nginx2;
		gl2;
	}
	subgraph cluster3 {
		nginx3;
		gl3;
	}
	LB -> nginx1 [label="Keepalive active link",lhead=cluster1] # lhead to a subgraph cluster make think we're linking to it instead of the edge
	LB -> nginx2 [style=dotted, lhead=cluster2];
	LB -> nginx3 [style=dotted, lhead=cluster3];
}
```
