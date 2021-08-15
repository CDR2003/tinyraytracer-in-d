import std.stdio;
import std.algorithm;
import std.random;
import std.conv;
import std.process;

import gml;

Color rayTrace(const World world, const Ray ray)
{
	auto hitResults = world.hit(ray);
	if (hitResults.length > 0)
	{
		auto result = hitResults[0];
		return (result.normal + Vector3.one) * 0.5f;
	}

	immutable auto direction = ray.direction.normalized;
	immutable auto t = 0.5f * (direction.y + 1.0f);
	return lerp(Color(1.0f, 1.0f, 1.0f), Color(0.5f, 0.7f, 1.0f), t);
}

void main()
{
	immutable float aspectRatio = 16f / 9f;
	immutable int width = 400;
	immutable int height = cast(int)(width / aspectRatio);
	immutable int samplesPerPixel = 100;

	auto world = new World();
	world.addObject(new Sphere(0.5f, Vector3(0, 0, 1)));
	world.addObject(new Sphere(100f, Vector3(0, -100.5f, 1)));

	auto camera = new Camera();

	auto texture = new Texture(width, height);
	for (int y = 0; y < texture.height; y++)
	{
		for (int x = 0; x < texture.width; x++)
		{
			auto colorSum = Color.zero;
			for (int s = 0; s < samplesPerPixel; s++)
			{
				immutable auto u = (cast(float)x + cast(float)uniform01()) / texture.width;
				immutable auto v = (cast(float)y + cast(float)uniform01()) / texture.height;
				immutable auto ray = camera.getRay(u, v);
				immutable auto color = rayTrace(world, ray);
				colorSum += color;
			}
			texture[x, y] = colorSum / samplesPerPixel;
		}
		writefln("%d / %d", y + 1, texture.height);
	}
	texture.saveToPpm("../out.ppm");

	spawnShell("start ../out.ppm");
}