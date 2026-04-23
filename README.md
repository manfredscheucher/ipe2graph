# ipe2graph

Extract a graph from an [Ipe](https://ipe.otfried.org/) drawing and export it as sparse6 and PNG.

[Ipe](https://ipe.otfried.org/) is a free, extensible vector graphics editor designed for creating figures in mathematical publications. It uses an XML-based `.ipe` file format and integrates well with LaTeX. It is particularly popular in computational geometry for drawing graphs, arrangements, and other combinatorial structures.

Vertices are identified as `mark/disk(sx)` marks in the Ipe file; edges are `path` elements connecting two such marks. Affine matrix transformations on both marks and paths are handled automatically.

## Usage

```
sage ipe2graph2.sage <file.ipe>
```

Outputs:
- `<file.ipe>.png` — visualization of the graph with its embedded positions
- `<file.ipe>.s6` — graph in sparse6 format (one line)

## Related

- [tuttedraw](https://github.com/manfredscheucher/tuttedraw) — compute Tutte embeddings and visualize planar graphs as Ipe, PDF, or PNG

## Example

The included example is the [Koester graph](https://en.wikipedia.org/wiki/Koester_graph), a 4-chromatic triangle-free planar graph.

```
$ sage ipe2graph2.sage examples/koester_graph.ipe
[(10, 13), (5, 10), (10, 15), (9, 10), (8, 13), (13, 15), (11, 13), (16, 17), (17, 19), (17, 24), (12, 17), (4, 24), (23, 24), (21, 24), (15, 18), (15, 20), (16, 18), (18, 20), (14, 18), (4, 7), (1, 4), (3, 4), (1, 3), (1, 23), (3, 6), (21, 23), (19, 21), (21, 22), (8, 11), (11, 12), (6, 8), (7, 8), (6, 7), (0, 22), (0, 20), (7, 12), (0, 2), (2, 5), (1, 2), (2, 23), (0, 5), (5, 9), (6, 9), (3, 9), (14, 16), (12, 14), (11, 14), (16, 19), (19, 22), (20, 22)]
wrote png to examples/koester_graph.ipe.png
wrote spars6 string to examples/koester_graph.ipe.s6
```

## Dependencies

- [SageMath](https://www.sagemath.org/)
