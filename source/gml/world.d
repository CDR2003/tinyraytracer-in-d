module gml.world;

import gml.scene_object;
import gml.hit_result;
import gml.ray;

public class World
{
    private SceneObject[] _objects;

    public this()
    {
        _objects = [];
    }

    public void addObject(SceneObject object)
    {
        _objects ~= object;
    }

    public HitResult[] hit(const Ray ray) const
    {
        HitResult[] results = [];
        foreach (object; _objects)
        {
            results ~= object.hit(ray);
        }
        return results;
    }
}