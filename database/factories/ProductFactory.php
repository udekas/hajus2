<?php

namespace Database\Factories;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;
use Faker\Factory as FakerFactory;

$faker = FakerFactory::create();


/**
 * @extends Factory<Product>
 */
class ProductFactory extends Factory
{
    protected $model = Product::class;

    public function definition(): array
{
    return [
        'name' => $this->faker->sentence(2),
        'description' => $this->faker->sentence(5),
        'image' => $this->faker->imageUrl(400, 400),
        'price' => $this->faker->numberBetween(10, 200),
    ];
}

}
