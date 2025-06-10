<script setup lang="ts">
import Input from '@/components/ui/input/Input.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { router } from '@inertiajs/vue3';
import { Trash } from 'lucide-vue-next';

const formatCurrency = (amount: number) => {
  return new Intl.NumberFormat('et', {
    style: 'currency',
    currency: 'EUR',
  }).format(amount);
};

const updateCart = (id: number | string, quantity: number | string) => {
  router.post(route('cart.update'), {
    id,
    quantity,
  });
};

const removeFromCart = (id: number | string) => {
  router.delete(route('cart.remove'), {
    data: { id },
    preserveScroll: true,
  });
};

const goToCheckout = () => {
  router.visit(route('checkout.index'));
};
</script>

<template>
  <AppLayout>
    <div class="container mx-auto p-6">
      <h1 class="mb-8 text-3xl font-extrabold text-gray-800 text-center tracking-tight">Shopping Cart</h1>
      <div class="rounded-2xl bg-white p-8 shadow-xl border border-gray-100">
        <table class="w-full border-collapse text-left mb-6">
          <thead>
            <tr class="bg-gray-50">
              <th class="border-b px-6 py-4 font-semibold text-gray-600">Image</th>
              <th class="border-b px-6 py-4 font-semibold text-gray-600">Product</th>
              <th class="border-b px-6 py-4 font-semibold text-gray-600">Price</th>
              <th class="border-b px-6 py-4 font-semibold text-gray-600">Quantity</th>
              <th class="border-b px-6 py-4 font-semibold text-gray-600">Total</th>
              <th class="border-b px-6 py-4 text-right font-semibold text-gray-600">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(item, id) in $page.props.cart"
              :key="id"
              class="hover:bg-gray-50 transition"
            >
              <td class="border-b px-6 py-4">
                <img
                  :src="item.image"
                  alt="Product Image"
                  class="h-16 w-16 rounded-lg object-cover border border-gray-200 shadow-sm"
                />
              </td>
              <td class="border-b px-6 py-4 text-gray-800 font-medium">{{ item.name }}</td>
              <td class="border-b px-6 py-4 text-gray-700">{{ formatCurrency(item.price) }}</td>
              <td class="border-b px-6 py-4">
                <Input
                  class="w-full max-w-24 text-right border-gray-300 rounded focus:ring-blue-500 focus:border-blue-500"
                  type="number"
                  :min="1"
                  :model-value="item.quantity"
                  @update:model-value="(val) => updateCart(id, val)"
                />
              </td>
              <td class="border-b px-6 py-4 text-gray-700">{{ formatCurrency(item.price * item.quantity) }}</td>
              <td class="border-b px-6 py-4 text-right">
                <button
                  @click="removeFromCart(id)"
                  class="p-2 rounded-full hover:bg-red-100 transition"
                  title="Remove item"
                >
                  <Trash class="w-5 h-5 text-red-600" />
                </button>
              </td>
            </tr>
          </tbody>
        </table>

        <div class="mt-6 flex justify-end">
          <div class="bg-gray-50 rounded-lg px-6 py-4 shadow flex items-center gap-4">
            <span class="text-lg font-semibold text-gray-700">Total:</span>
            <span class="text-2xl font-bold text-blue-700">{{ formatCurrency($page.props.cartTotal) }}</span>
          </div>
        </div>

        <div class="mt-8 flex justify-end">
          <button
            @click="goToCheckout"
            class="rounded-lg bg-blue-600 px-8 py-3 text-lg font-semibold text-white shadow hover:bg-blue-700 transition"
          >
            Proceed to Payment
          </button>
        </div>
      </div>
    </div>
  </AppLayout>
</template>
