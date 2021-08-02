import std.stdio;
import std.algorithm;
import std.conv;
import std.process;

import gml;

void main()
{
	immutable int width = 256;
	immutable int height = 256;

	auto texture = new Texture(width, height);
	for (int y = 0; y < texture.height; y++)
	{
		for (int x = 0; x < texture.width; x++)
		{
			auto color = Color();
			color.r = cast(float)x / (width - 1);
			color.g = cast(float)y / (height - 1);
			color.b = 0.25f;
			texture[x, y] = color;
		}
	}
	texture.saveToPpm("../out.ppm");

	spawnShell("start ../out.ppm");
}