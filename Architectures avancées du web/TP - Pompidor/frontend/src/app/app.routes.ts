import { Route } from '@angular/router';
import { Products } from './products/products';
import { Cart } from './cart/cart';

export const routes: Route[] = [
    { path: 'products', component: Products },
    { path: 'cart', component: Cart },
];