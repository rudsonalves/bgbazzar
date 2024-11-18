// Copyright (C) 2024 Rudson Alves
// 
// This file is part of bgbazzar.
// 
// bgbazzar is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// bgbazzar is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with bgbazzar.  If not, see <https://www.gnu.org/licenses/>.

// Importa axios para fazer requisições HTTP
const axios = require('axios');

// Define uma função de Cloud Code que cria uma preferência de pagamento
Parse.Cloud.define("createPaymentPreference", async (request) => {
  // Obtém os parâmetros do request
  const { items, userEmail } = request.params;

  try {
    // Constrói a lista de itens para a preferência de pagamento no formato esperado pela API do Mercado Pago
    const formattedItems = items.map(item => ({
      title: item.title,
      quantity: item.quantity,
      currency_id: "BRL",
      unit_price: item.unit_price
    }));

    // Faz a requisição POST para a API do Mercado Pago para criar a preferência de pagamento
    const response = await axios.post('https://api.mercadopago.com/checkout/preferences', {
      items: formattedItems,
      payer: {
        email: userEmail     // Email do comprador
      }
    }, {
      headers: {
        // Access Token do Mercado Pago
        'Authorization': `Bearer TEST-2732429871074196-102815-24b893b2dbcdb625aacf852992f34868-2050295551`
      }
    });

    // Retorna o ID da preferência gerada para ser usado no Payment Brick
    return { preferenceId: response.data.id };

  } catch (error) {
    // Tratamento de erro caso a requisição falhe
    console.error('Erro ao criar a preferência:', error.response ? error.response.data : error.message);
    throw new Error('Erro ao criar a preferência de pagamento.');
  }
});

Parse.Cloud.define("updateStockAndStatus", async (request) => {
  const itemsToPurchase = request.params.items; // Array de objetos { objectId: "id", quantity: quantidade }

  const itemIds = itemsToPurchase.map(item => item.objectId);
  const query = new Parse.Query("AdsSale");
  query.containedIn("objectId", itemIds);

  const items = await query.find({ useMasterKey: true });

  // Armazena os itens a serem atualizados
  const itemsToUpdate = [];

  for (const item of items) {
    const itemId = item.id;
    const requestedQuantity = itemsToPurchase.find(i => i.objectId === itemId).quantity;
    const currentStock = item.get("quantity");

    if (currentStock >= requestedQuantity) {
      // Decrementa o estoque e verifica se deve alterar o status para "sold"
      item.increment("quantity", -requestedQuantity);

      if (item.get("quantity") === 0) {
        item.set("status", 2); // Define o status para "sold"
      }

      itemsToUpdate.push(item);
    } else {
      // Retorna erro se o estoque for insuficiente para algum item
      return { success: false, message: "Insufficient stock", itemId, currentStock };
    }
  }

  // Se tudo está ok, atualiza os itens no Parse Server
  await Parse.Object.saveAll(itemsToUpdate, { useMasterKey: true });
  return { success: true, message: "Stock updated successfully" };
});

Parse.Cloud.afterSave(Parse.User, async (request) => {
  const user = request.object;

  // Verifique se é uma criação de usuário (e não uma atualização)
  if (!user.existed()) {
    try {
      // Busca o papel "user"
      const roleQuery = new Parse.Query(Parse.Role);
      roleQuery.equalTo("name", "user");
      const role = await roleQuery.first({ useMasterKey: true });

      if (!role) {
        throw new Error('Role "user" not found.');
      }

      // Adiciona o novo usuário ao papel "user"
      const relation = role.relation("users");
      relation.add(user);

      // Salva o papel
      await role.save(null, { useMasterKey: true });

      console.log(`User ${user.id} successfully added to role "user".`);
    } catch (error) {
      console.error(
        `Failed to add user ${user.id} to role "user": ${error.message}`
      );
    }
  }
});
