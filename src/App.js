import React, { Component }  from 'react';
import "./App.css"
import { useEffect, useState } from 'react/cjs/react.development';
import { async, ninvoke } from 'q';
import Web3 from "web3";
import detectEthereumProvider from '@metamask/detect-provider'

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null
  })

  const [account, setAccount] = useState(null)

  useEffect(() => {
    const loadProvider = async () => {
      const provider = await detectEthereumProvider()

      if (provider) {
        // provider.request({method: "eth_requestAccounts"})
        setWeb3Api({
          web3: new Web3(provider),
          provider
        })
      } else {
        console.error("Please, install Metamask")
      }

      // if (window.ethereum) {
      //   provider = window.ethereum;

      //   try {
      //     await provider.request({method: "eth_requestAccounts"});
      //   } catch {
      //     console.error("User denied accounts access!")
      //   }
      // } else if (window.web3) {
      //   provider = window.web3.currentProvider
      // } else if (!process.env.production) {
      //   provider = new Web3.providers.HttpProvider("http://localhost:7545")
      // }

      // setWeb3Api({
      //   web3: new Web3(provider),
      //   provider
      // })

      // with metamask we haev an access to window.ethereum & to window.web3
      // metamask injects a global API into website
      // this API allows websites to request users, accounts, read data to blockchain,
      // sign messages and transactions

      // console.log(window.web3)
      // console.log(window.ethereum)
    }

    loadProvider()
  }, [])

  useEffect(() => {
    const getAccount = async () => {
      const accounts = await web3Api.web3.eth.getAccounts()
      setAccount(accounts[0])
    }

   web3Api.web3 && getAccount()
  }, [web3Api.web3])

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">
        <div className="is-flex is-align-items-center">
          <span>
            <strong className="mr-2">Account: </strong>
          </span>
            { account ?
              <div>{account}</div>:
              <button
                className="button is-small"
                onClick={() => web3Api.provider.request({method: "eth_requestAccounts"})}
              >
                Connect Wallet
              </button> 
            }
          </div>
          <div className="balance-view is-size-2 my-4">
            Current Balance: <strong>10</strong> ETH
          </div>
          {/* <button 
            className="btn mr-2"
            onClick={async () => {
              const accounts = await window.ethereum.request({method: "eth_requestAccounts"})
              console.log(accounts)
            }}
          >
            Enable Ethereum
          </button> */}
          <button className="button is-link mr-2">Donate</button>
          <button className="button is-primary">Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;