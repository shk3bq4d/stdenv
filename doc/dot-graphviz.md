layout:
 circo dot fdp neato nop nop1 nop2 osage patchwork sfdp twopi

http://www.webgraphviz.com/
https://graphviz.gitlab.io/_pages/doc/info/attrs.html
https://www.tonyballantyne.com/graphs.html

```dot
digraph graphname {
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
```
