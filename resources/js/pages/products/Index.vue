<script setup lang="ts">
import { hydrate, reactive } from 'vue';
import axios from 'axios';
import { Link, router } from '@inertiajs/vue3';
import AppLayout from '@/layouts/AppLayout.vue';
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle
} from '@/components/ui/card';
import { ShoppingCart, Trash } from 'lucide-vue-next';
import { Button } from '@/components/ui/button';

interface Product {
  id: number;
  name: string;
  description: string;
  image: string;
  price: number;
  created_at: string;
  updated_at: string;
}

const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('et', {
        style: 'currency',
        currency: 'EUR',
    }).format(amount);
};
const props = defineProps<{ products: Product[] }>();

const addToCart = (product:Product) => {
    router.post(route('cart.add', product), undefined, {
        preserveScroll: true,
    });
   
};

const clear = () => {
    router.post(route('cart.clear'));
};
 

</script>

<template>
  <AppLayout>
    <!-- Header Bar -->
    <div class="flex justify-end items-center p-6 gap-4 bg-white shadow rounded-xl mb-8">
      <Link
        :href="route('cart.checkout')"
        size="icon"
        variant="outline"
        class="relative rounded-full border border-gray-300 p-3 hover:bg-blue-50 transition"
        aria-label="Go to cart"
      >
        <ShoppingCart class="w-6 h-6 text-blue-700" />
        <span
          v-if="$page.props.cartCount > 0"
          class="absolute -top-1 -right-1 bg-red-600 text-white text-xs font-bold px-2 py-0.5 rounded-full shadow"
        >
          {{ $page.props.cartCount }}
        </span>
      </Link>
      <Button
        @click="clear"
        size="icon"
        variant="destructive"
        class="relative rounded-full p-3 hover:bg-red-100 transition"
        aria-label="Clear cart"
      >
        <Trash class="w-6 h-6" />
      </Button>
    </div>

    <!-- Products Grid -->
    <div class="p-6 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
      <Card
        v-for="product in props.products"
        :key="product.id"
        class="h-full flex flex-col shadow-lg hover:shadow-2xl transition rounded-2xl bg-white"
      >
        <CardHeader class="p-4 pb-2 flex flex-col items-center">
          <img
            :src="product.image"
            alt="product image"
            class="w-full h-48 object-cover rounded-xl mb-4 border border-gray-100 shadow-sm"
          />
          <CardTitle class="text-xl font-bold text-gray-800 mb-1 text-center">
            {{ product.name }}
          </CardTitle>
          <CardDescription class="text-gray-500 text-sm mb-2 text-center">
            {{ product.description }}
          </CardDescription>
          <p class="text-lg font-semibold text-blue-700 mb-2 text-center">
            {{ formatCurrency(product.price) }}
          </p>
        </CardHeader>
        <CardContent class="p-4 pt-0 mt-auto">
          <button
            @click="addToCart(product)"
            class="bg-gradient-to-r from-blue-600 to-blue-500 text-white py-2 px-4 rounded-xl w-full font-semibold shadow hover:from-blue-700 hover:to-blue-600 transition"
          >
            Add to Cart
          </button>
        </CardContent>
      </Card>
    </div>
  </AppLayout>
</template>
