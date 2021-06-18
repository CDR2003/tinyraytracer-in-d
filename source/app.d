import std.stdio;
import std.algorithm;
import std.conv;
import gml.vector;

void main()
{
	immutable int width = 256;
	immutable int height = 256;

	auto file = File("../out.ppm", "w");
	scope(exit) file.close();

	file.writeln("P3");
	file.writefln("%d %d", width, height);
	file.writeln("255");

	for (int y = height - 1; y >= 0; --y)
	{
		for (int x = 0; x < width; x++)
		{
			auto r = cast(double)x / (width - 1);
			auto g = cast(double)y / (height - 1);
			auto b = 0.25;

			auto ir = cast(int)(r * 255.999);
			auto ig = cast(int)(g * 255.999);
			auto ib = cast(int)(b * 255.999);

			file.writefln("%d %d %d", ir, ig, ib);
		}
	}
}