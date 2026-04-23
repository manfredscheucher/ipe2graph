# ipe2graph

Extract a graph from an [Ipe](https://ipe.otfried.org/) drawing and export it as sparse6 and PNG.

Vertices are identified as `mark/disk(sx)` marks in the Ipe file; edges are `path` elements connecting two such marks. Affine matrix transformations on both marks and paths are handled automatically.

## Usage

```
sage ipe2graph2.sage <file.ipe>
```

Outputs:
- `<file.ipe>.png` — visualization of the graph with its embedded positions
- `<file.ipe>.s6` — graph in sparse6 format (one line)

## Example

```
$ sage ipe2graph2.sage examples/koester_graph.ipe
[(0, 1), (0, 2), ...]
wrote png to examples/koester_graph.ipe.png
wrote sparse6 string to examples/koester_graph.ipe.s6
```

## Dependencies

- [SageMath](https://www.sagemath.org/)
