module gml.sphere;

import std.container.array;
import std.math;
import gml.vector;
import gml.ray;
import gml.scene_object;
import gml.hit_result;

public class Sphere : SceneObject
{
    private float _radius;

    public this(float radius)
    {
        this(radius, Vector3.zero);
    }

    public this(float radius, const Vector3 position)
    {
        _radius = radius;
        this.position = position;
    }

    public float radius() pure const nothrow
    {
        return _radius;
    }

    public override HitResult[] hit(const Ray ray) pure const
    {
        immutable auto offset = ray.origin - this.position;
        immutable auto a = ray.direction.squaredMagnitude;
        immutable auto b = dot(offset, ray.direction) * 2;
        immutable auto c = offset.squaredMagnitude - this.radius * this.radius;
        immutable auto delta = b * b - 4 * a * c;
        if (delta < 0)
        {
            return [];
        }

        HitResult[] results = [];
        immutable auto sqrtDelta = sqrt(delta);
        immutable auto root1 = (-b - sqrtDelta) / 2 / a;
        immutable auto root2 = (-b + sqrtDelta) / 2 / a;
        addResult(results, ray, root1);
        if (delta > 0)
        {
            addResult(results, ray, root2);
        }
        return results;
    }

    private void addResult(ref HitResult[] results, const Ray ray, float distance) pure const
    {
        if (distance < 0)
        {
            return;
        }

        immutable auto position = ray.origin + ray.direction * distance;
        immutable auto normal = (position - this.position).normalized;
        immutable auto result = HitResult(position, normal, distance);
        results ~= result;
    }
}