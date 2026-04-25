#!/usr/bin/env sage
import argparse
import xml.etree.ElementTree as ET


def ipe2graph(path):
	"""Read a graph from an IPE file and return a SageMath Graph."""
	tree = ET.parse(path)
	root = tree.getroot()
	page = root.find('page')

	P = []
	for u in page.iterfind('use'):
		attr = u.attrib
		if attr['name'] == 'mark/disk(sx)':
			x, y = [float(t) for t in attr['pos'].split(" ")]

			if 'matrix' in attr:
				M = [float(t) for t in attr['matrix'].split(" ")]
				x0 = x
				y0 = y
				x = M[0]*x0 + M[2]*y0 + M[4]
				y = M[1]*x0 + M[3]*y0 + M[5]

			x = round(x, 1)
			y = round(y, 1)
			p = (x, y)
			assert(p not in P)  # valid embedding
			P.append(p)

	E = []
	for u in page.iterfind('path'):
		attr = u.attrib
		M = None
		if 'matrix' in attr:
			M = [float(t) for t in attr['matrix'].split(" ")]

		lines = u.text.split("\n")
		pts = []
		for l in lines:
			if l == '':
				continue
			x, y = [float(z) for z in l.split()[:2]]
			if M is not None:
				x0 = x
				y0 = y
				x = M[0]*x0 + M[2]*y0 + M[4]
				y = M[1]*x0 + M[3]*y0 + M[5]
			x = round(x, 1)
			y = round(y, 1)
			p = (x, y)
			if p not in P:
				print("WARNING:", p, "not a point of", P)
				continue
			i = P.index(p)
			pts.append(i)
		assert(len(pts) == 2)  # no hypergraph

		pts.sort()
		e = tuple(pts)
		if e not in E:
			E.append(e)

	G = Graph(E)
	pos = {i: p for i, p in enumerate(P)}
	G.set_pos(pos)
	return G


if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		description="Read a graph from an IPE file and export as PNG and sparse6.")
	parser.add_argument("ipe_file", help="path to the .ipe input file")
	args = parser.parse_args()

	path = args.ipe_file
	G = ipe2graph(path)

	png_path = path + ".png"
	G.plot().save(png_path)
	print(G.edges(labels=0))
	print(f"wrote png to {png_path}")

	s6_path = path + ".s6"
	with open(s6_path, "w") as f:
		f.write(G.sparse6_string() + "\n")
	print(f"wrote spars6 string to {s6_path}")
