//
//  StellarManager.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import stellarsdk
class StellarManager{
    
    static func generatePublicKey() -> String{
        let mnemonic = Wallet.generate12WordMnemonic()
        return mnemonic
    }
    
    static func generateSecretSeedFrom(mnemonic:String) -> KeyPair?{
        do{
            let keyPair = try Wallet.createKeyPair(mnemonic: mnemonic.lowercased(), passphrase: nil, index: 0)
            let signerKeyPair = try KeyPair(secretSeed: keyPair.secretSeed!)
            return signerKeyPair
        }catch{
            return nil
        }
    }
    
    static func signTransactionHash(hash:String) -> String?{
        let user = (UIApplication.shared.delegate as! AppDelegate).user!
        let secretSeed = UserDefaults.standard.object(forKey: "\(user.id)-secretSeed") as! String
        let signerKeyPair = try! KeyPair.init(secretSeed: secretSeed)
        let transactionEnvelopeXDR = try! TransactionEnvelopeXDR(xdr: hash)
        let tx = transactionEnvelopeXDR.tx
        let transactionHash = try! [UInt8](tx.hash(network:.privateNetwork))
        let userSignature = signerKeyPair.signDecorated(transactionHash)
        transactionEnvelopeXDR.signatures.append(userSignature)
        let xdrEncodedEnvelope = transactionEnvelopeXDR.xdrEncoded
        return xdrEncodedEnvelope
    }

}
